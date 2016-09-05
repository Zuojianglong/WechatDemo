//
//  ChatViewcontroller.m
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import "ChatViewcontroller.h"
#import "XMPPJID.h"
#import "ChatButtonView.h"
#import "LGEmotion.h"
#import "LGEmotionAttAchment.h"
#import "SendTextView.h"
#import "LGEmotionKeyboard.h"
#import "MessageModel.h"
#import "MessageFrameModel.h"
#import "ChatViewCell.h"

#define cellID @"ChatViewCell"
@interface ChatViewcontroller ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate,ChatButtonViewDelegate>
@property (nonatomic,weak) UITableView *chatTable;//定义一个表
//查询结果集合
@property (nonatomic,weak) ChatButtonView *chatBottom;
@property (nonatomic,strong) NSFetchedResultsController *resultController;
@property (nonatomic,weak) SendTextView *bottomInputView;//输入框
@property (nonatomic,strong) NSMutableArray *frameModelArr;//存放messageFrameModel的数组
@property (nonatomic,strong) LGEmotionKeyboard *keyboard;//表情键盘
@property (nonatomic,strong) NSData *headImage;//用户头像
@property (nonatomic,assign) BOOL isChangeHeight;//
@property (nonatomic,assign) CGFloat tableViewHeight;//表的高
@property (nonatomic,assign) BOOL changeKeyboard;//梳头改变键盘的样式


@end
@implementation ChatViewcontroller
- (NSMutableArray *)frameModelArr{
    if (!_frameModelArr) {
        _frameModelArr = [NSMutableArray array];
    }
    
    return _frameModelArr;
}
- (LGEmotionKeyboard *)keyboard{
    if (!_keyboard) {
        self.keyboard.width = ScreenWidth;
        self.keyboard.height = 216;
    }
    return _keyboard;
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //添加表视图
    [self setupTableView];
    //加载聊天数据
    [self loadChatData];
    //添加底部view
    [self setupBottomView];
    //选中表情的监听
    [Mynotification addObserver:self selector:@selector(emotionDidSelected:) name:LGEmotionDidSelectedNotification object:nil];
    //删除按钮的监听
    [Mynotification addObserver:self selector:@selector(emotionDidDeleted:) name:LGEmotionDidDeletedNotification object:nil];
    
    //监听表情发送按钮点击
    [Mynotification addObserver:self selector:@selector(faceSend) name:FaceSendButton object:nil];
    
}
- (void)setupTableView{
    if (self.chatTable==nil) {
        UITableView *table = [[UITableView alloc]init];
        table.allowsSelection = NO;//不可以被选中
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        CGFloat tableH = self.view.height-64-BottomHeight;
        self.tableViewHeight = tableH;//记录表的高度
        table.frame = CGRectMake(0, 0, ScreenWidth, tableH);
        table.delegate = self;
        table.dataSource = self;
        [self.view addSubview:table];
        self.chatTable = table;
        [table registerClass:[ChatViewCell class] forCellReuseIdentifier:cellID];
        
    }
}
#pragma mark 加载聊天数据
- (void)loadChatData{
    NSLog(@"加载聊天数据");
    UserOperation *user = [UserOperation shareduser];
    NSString *myName = [NSString stringWithFormat:@"%@@%@",user.uname,ServerName];
    XMPPTools *tool = [XMPPTools sharedxmpp];
    self.headImage = tool.vCard.myvCardTemp.photo;//获得用户头像
    //上下文
    NSManagedObjectContext *context = tool.messageStroage.mainThreadManagedObjectContext;
    //请求对象 XMPPMessageArchiving_Message_CoreDataObject
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
    //过滤条件和排序 bareJidStr(聊天的用户)  streamBareJidStr(我)
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr=%@ AND bareJidStr=%@",myName,self.jid.bare];
    fetch.predicate = pre;
    //排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    fetch.sortDescriptors = @[sort];
    //查询
    _resultController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetch managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    NSError *error = nil;
    _resultController.delegate = self;
    [_resultController performFetch:&error];
    if (_resultController.fetchedObjects.count) {
        //数据转模型
        [self dataToModel];
        
        [self.chatTable reloadData];//刷新表的数据
        //滚到最后一行
        [self scrollToBottom];
    }
 
    if (error) {
        NSLog(@"查询聊天数据错误:%@",error);
    }
    
}
#pragma mark 数据转模型
- (void)dataToModel{
    for (XMPPMessageArchiving_Message_CoreDataObject *msg in _resultController.fetchedObjects) {
        MessageModel *msgModel = [MessageModel new];
        msgModel.body = msg.body;
        msgModel.time = [NSString stringWithFormat:@"%@",msg.timestamp];
        msgModel.to = msg.bareJidStr;
        msgModel.otherPhoto = self.photo;//聊天用户的头像;
        msgModel.headImage = self.headImage;//自己的头像
        msgModel.HiddenTime = YES;//隐藏时间
        
        //判断是不是当前用户
        msgModel.isCurrentUser = [[msg outgoing] boolValue];
        
        //把数据保存到frmaeModel
        MessageFrameModel *frameModel = [MessageFrameModel new];
        frameModel.messageModel = msgModel;
        [self.frameModelArr addObject:_frameModelArr];//添加到数组中
        
    }

}
#pragma mark 滚动到最后一行
- (void)scrollToBottom{
    
    if (!self.frameModelArr.count) {
        return;
    }
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.frameModelArr.count-1 inSection:0];
    
    [self.chatTable scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
}
#pragma mark 收到新的消息(UIFetchedResultsControllerDelegate)
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    //每收到一条消息执行的方法
    
    XMPPMessageArchiving_Message_CoreDataObject *msg = self.resultController.fetchedObjects.lastObject;
    [self dataToModelWith:msg];//收到消息就保存到模型中;
    //如果是当前用户
    if ([[msg outgoing] boolValue]) {
        NSString *uname = [self cutStr:msg.bareJidStr];
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *strDate = [formatter stringFromDate:msg.timestamp];//获得时间
        NSDictionary *dict = @{@"uname":uname,@"time":strDate,@"body":msg.body,@"jid":msg.bareJid,@"user":@"this"};
        NSNotification *note = [[NSNotification alloc]initWithName:SendMsgName object:dict userInfo:nil];
        [Mynotification postNotification:note];
        
        
    }
    
    
}
#pragma mark 把聊天数据转成模型
-(void)dataToModelWith:(XMPPMessageArchiving_Message_CoreDataObject*)msg{
    
    if (msg.body !=nil) {
        
        MessageModel *msgModel = [MessageModel new];
        msgModel.body = msg.body;
        msgModel.time=[NSString stringWithFormat:@"%@",msg.timestamp];
        msgModel.to=msg.bareJidStr;
        msgModel.otherPhoto=self.photo;
        msgModel.headImage = self.headImage;//获取自己的头像
        msgModel.HiddenTime=YES; //隐藏时间
        //是不是当前用户
        msgModel.isCurrentUser=[[msg outgoing] boolValue];
        //根据frameModel模型设置frame
        MessageFrameModel *frameModel=[[MessageFrameModel alloc]init];
        frameModel.messageModel=msgModel;
        //把frameModel添加到数组中
        [self.frameModelArr addObject:frameModel];

    }
    
}
#pragma mark 添加底部的View
- (void)setupBottomView{
    
    ChatButtonView *bottom = [ChatButtonView new];
    bottom.bottomInputView.delegate = self;
    bottom.delegate = self;
    bottom.left = 0;
    bottom.top = self.view.height-64-bottom.height;
    [self.view addSubview:bottom];
    self.chatBottom = bottom;
    //传递输入框
    self.bottomInputView = bottom.bottomInputView;
    //监听键盘的移动
    [Mynotification addObserver:self selector:@selector(keybordAppear:) name:UIKeyboardWillShowNotification object:nil];
    [Mynotification addObserver:self selector:@selector(keybordHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}
#pragma mark 点击底部按钮的代理方法
- (void)chatBottomView:(ChatButtonView *)bottomView buttonTag:(BottomButtonType)buttonTag{
    
    switch (buttonTag) {
        case BottomButtonTypeEmotion://打开表情的键盘
            [self openEmotion];
            break;
        case BottomButtonTypeAddPicture://打开添加图片的键盘
            [self addPicture];
            break;
        case BottomButtonTypeAudio://打开添加语音的键盘
            
            break;
            
        default:
            break;
    }
    
    
}
#pragma mark 打开表情键盘
-(void)openEmotion{
    
    
    
}
#pragma mark 打开添加图片的键盘
-(void)addPicture
{
    NSLog(@"addPicture");
}
#pragma mark 通知,选定表情执行的方法
- (void)emotionDidSelected:(NSNotification *)note{
    LGEmotion *emotion = note.userInfo[LGSelectedEmotion];
    //拼接表情
    [self.bottomInputView appendEmotion:emotion];
    //监测文字的长度
    [self textViewDidChange:self.bottomInputView];
    
}
#pragma mark  当点击表情键盘上的删除按钮时调用
- (void)emotionDidDeleted:(NSNotification *)note{
    //往回删除
    [self.bottomInputView deleteBackward];
    
    
}
#pragma mark 表情按钮点击发送
-(void)faceSend{
    NSString *str = _bottomInputView.text.deleteSpace;
    if (str.length < 1) {
        return;
    }
    //发送消息
    [self sendMsgWithText:_bottomInputView.realText bodyType:@"text"];
    self.bottomInputView.text = nil;
    
    
}
#pragma mark 发送消息
- (void)sendMsgWithText:(NSString *)text bodyType:(NSString*)bodyType{
    
    XMPPMessage *msg = [XMPPMessage messageWithType:@"chat" to:self.jid];
    XMPPTools *tool = [XMPPTools sharedxmpp];
      // 设置内容   text指纯文本  image指图片  audio指语音
    [msg addAttributeWithName:@"bodyType" stringValue:bodyType];
    [msg addBody:text];
    [tool.xmppStream sendElement:msg];//发送消息
    
}
#pragma mark ------------------------键盘的通知
#pragma mark 通知,键盘将要出现的时候
-(void)keybordAppear:(NSNotification*)note{
    
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        
        [self scrollToBottom];//滚动到最后一行
        self.chatBottom.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);//改变平移位置
        //如果数组中的模型大于5个就平移
        if (self.frameModelArr.count > 5) {
            self.chatTable.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
            return ;
        }
        if (self.isChangeHeight == NO) {
            if (ScreenHeight<568) {//4/4s
                self.chatTable.height = self.chatTable.height-keyboardF.size.height;
            }else{//5s 6 6p
                
                self.chatTable.height = self.chatTable.height-BottomHeight*0.5-keyboardF.size.height;
                
            }

            self.isChangeHeight = YES;//已经改变了表的高度;
        }
    }];
    
    
}
#pragma mark 键盘将要隐藏的时候
-(void)keybordHide:(NSNotification*)note{
    if(self.changeKeyboard) return;
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.chatBottom.transform = CGAffineTransformIdentity;
        //如果数组中的模型树>5不改变高度
        if (self.frameModelArr.count>5) {
            self.chatTable.transform = CGAffineTransformIdentity;
        }
        if (self.chatTable.height<self.tableViewHeight) {
            self.chatTable.height =self.tableViewHeight;
        }
        
        self.isChangeHeight = NO;
        
    }];
  
}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.frameModelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    MessageFrameModel *frameModel = self.frameModelArr[indexPath.row];
    cell.frameModel = frameModel;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageFrameModel *frameModel=self.frameModelArr[indexPath.row];
    return frameModel.cellHeight;
}
#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    //当textView的文字改变就会调用
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //写这个是为了不会在keyboardWillShow里面在调整tableView的高度(否则会错乱)
    self.isChangeHeight = YES;
    if ([text isEqualToString:@"\n"]) {
        
    NSString *body = textView.text.deleteSpace;
    if ([body isEqualToString:@""]) return NO;
    [self sendMsgWithText:_bottomInputView.realText bodyType:@"text"];
    self.bottomInputView.text = @"";
    
        return NO;
    }
    return YES;
}
#pragma  mark 去掉@符号
-(NSString*)cutStr:(NSString*)str
{
    NSArray *arr=[str componentsSeparatedByString:@"@"];
    return arr[0];
}

-(void)dealloc
{
    [Mynotification removeObserver:self];
    
}
@end
