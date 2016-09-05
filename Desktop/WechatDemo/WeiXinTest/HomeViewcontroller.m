//
//  HomeViewcontroller.m
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import "HomeViewcontroller.h"
#import "HomeModel.h"
#import "UIBarButtonItem+LG.h"
#import "HomeViewCell.h"
#import "ChatViewcontroller.h"
#import "FMDBMessage.h"

#define cellID @"HomeViewCell"
@interface HomeViewcontroller ()
@property (nonatomic,strong) NSMutableArray *chatDatas;//存放聊天最后一段信息的数组
@property (nonatomic,assign) int messageCount; //未读消息的总数
@end
@implementation HomeViewcontroller
- (instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}
- (NSMutableArray *)chatDatas{
    if (!_chatDatas) {
        _chatDatas = [NSMutableArray array];
    }
    
    return _chatDatas;
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self setupSearchBar];//搜索条
    [self readChatDatas];//聊天数据
    [self.tableView registerClass:[HomeViewCell class] forCellReuseIdentifier:cellID];//注册cell;
    //监听消息来得通知
    [Mynotification addObserver:self selector:@selector(messageCome:) name:SendMsgName object:nil];
    //监听删除好友时发出的通知
    [Mynotification addObserver:self selector:@selector(deleteFriend:) name:DeleteFriend object:nil];
    
    
}
#pragma mark 添加搜索栏
- (void)setupSearchBar{
    
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.frame = CGRectMake(10, 5, ScreenWidth-20, 25);
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;//取消首字母大写
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.placeholder = @"搜索";
    searchBar.layer.borderWidth = 0;
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    searchView.backgroundColor = LGColorAlpha(189, 189, 195, 0.7);
    [searchView addSubview:searchBar];
    self.tableView.tableHeaderView = searchView;
 
}
#pragma mark 导航右按钮
- (void)setupRightButton{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"barbuttonicon_add" highIcon:nil target:self action:@selector(rightClick)];
    
    
}
- (void)rightClick{
    
    NSLog(@"导航右按钮被点击了!");
}
#pragma mark 从本地数据库读取聊天记录
- (void)readChatDatas{
    
    
    NSArray *datas = [FMDBTools selectAllDatas];
    self.chatDatas = [datas mutableCopy];
    //未读消息的条数
    for (HomeModel *model in datas) {
        if (model.badgeValue.length>0 && ![model.badgeValue isEqualToString:@""]) {
            int currentValue = model.badgeValue.intValue;
            self.messageCount +=currentValue;
        }
    }
    if (self.messageCount>0) {
        
        if (self.messageCount >= 99) {
            self.tabBarItem.badgeValue = @"99+";
        }else{
            
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",self.messageCount];
        }
    }
}
#pragma mark 有消息来的通知
- (void)messageCome:(NSNotification *)note{
    
    NSDictionary *dict = note.object;
    //设置未读消息总数消息 ([dict[@"user"]如果是正在和我聊天的用户才设置badgeValue)
    if ([dict[@"user"] isEqualToString:@"other"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.messageCount++;
            if (self.messageCount >=99) {
                self.tabBarItem.badgeValue = @"99+";
            }else{
                
                self.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",self.messageCount];
            }
        });
    }
    //修改信息
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateMessage:note];
    });
    
}
#pragma mark 修改本地数据
- (void)updateMessage:(NSNotification *)note{
    NSDictionary *dict = note.object;
    NSString *uname = dict[@"uname"];
    NSString *body = dict[@"body"];
    NSString *time = dict[@"time"];
    XMPPJID *jid = dict[@"jid"];
    NSString *user = dict[@"user"];
    //如果用户在本地数据已存在,就直接更新聊天数据
    if ([FMDBTools selectUname:uname]) {
        
        for (HomeModel *model in self.chatDatas) {
            if ([model.uname isEqualToString:uname]) {
                model.body = body;
                model.time = time;
                //如果不是正在聊天的用户 才设置badgeValue
                if ([user isEqualToString:@"other"]) {
                    int currentV=[model.badgeValue intValue]+1;
                    model.badgeValue=[NSString stringWithFormat:@"%d",currentV];
                }
                [self.tableView reloadData];
                //更新数据库的数据
                [FMDBTools updateWithName:uname detailName:body time:time badge:model.badgeValue];
            }
        }
        
    }else{//数据库中没有这个对象
        HomeModel *newModel = [HomeModel new];
        newModel.uname = uname;
        newModel.body = body;
        newModel.jid = jid;
        newModel.time = time;
        if ([user isEqualToString:@"other"]) {
            newModel.badgeValue = @"1";
        }else{
            newModel.badgeValue = nil;
        }
    
        [self.chatDatas addObject:newModel];
        [self.tableView reloadData];
        [FMDBTools addHead:nil uname:uname detailName:body time:time badge:newModel.badgeValue xmppjid:jid];
    }
}
#pragma mark 删除好友时的同步的数据
- (void)deleteFriend:(NSNotification*)note{
    NSString *uname = note.object;
    NSInteger index = 0;
    
    for (HomeModel *model in self.chatDatas) {
        if ([model.uname isEqualToString:uname]) {
            
            [_chatDatas removeObjectAtIndex:index];
            [FMDBTools deleteWithName:uname];
            [self.tableView reloadData];
        }
        index++;
    }
 
}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.chatDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    HomeModel *model = self.chatDatas[indexPath.row];
    cell.homeModel = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
#pragma mark 点击单元格的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //隐藏对象的小红点
    HomeModel *model = self.chatDatas[indexPath.row];
    //标签栏数字按钮的减少
    self.messageCount = self.messageCount-model.badgeValue.intValue;
    if (self.messageCount > 0) {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",self.messageCount];
    }else{
        self.tabBarItem.badgeValue = nil;
    }
    
    //清除模型中的数据 小红点数据
    model.badgeValue = nil;
    //刷新表
    [self.tableView reloadData];
    
    [FMDBTools clearRedPointWithName:model.uname];//清除数据库中的数据
    
    //跳转页面
    
    ChatViewcontroller *chatVc = [ChatViewcontroller new];
    chatVc.title = model.jid.user;
    chatVc.jid = model.jid;
    [self.navigationController pushViewController:chatVc animated:YES];
    
    
    
}
#pragma mark 删除单元格
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击删除按钮的事件;
    HomeModel *model = self.chatDatas[indexPath.row];
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        //删除对应的红色提醒按钮
        
        int badge = model.badgeValue.intValue;
        if (badge > 0) {
            
            _messageCount = _messageCount-badge;
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",_messageCount];
            
        }
        
        //删除该好友的所有聊天数据
        [FMDBMessage deleteChatData:[NSString stringWithFormat:@"%@@%@",model.uname,ServerName]];
        //删除缓存
        [self.chatDatas removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        //删除数据库的数据
        [FMDBTools deleteWithName:model.uname];
        
        
    }
 
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
    
}
- (void)dealloc{
    
    [Mynotification removeObserver:self];
    NSLog(@"通知销毁了");
    
}
@end
