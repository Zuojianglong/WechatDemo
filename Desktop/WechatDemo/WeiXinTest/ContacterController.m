//
//  ContacterController.m
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import "ContacterController.h"
#import "ContacterModel.h"
#import "UIBarButtonItem+LG.h"
#import "AddFriendController.h"
#import "ChatTogetherController.h"
#import "NewFriendViewController.h"
#import "ChatViewcontroller.h"
#import "ContacterCell.h"

#define cellID @"ContacterCell"
@interface ContacterController ()<NSFetchedResultsControllerDelegate>
@property (nonatomic,strong) NSFetchedResultsController *resultsController;
@property (nonatomic,strong) NSMutableArray *keys;//存放所有标示图分区的键
@property (nonatomic,strong) NSMutableDictionary *datas;//所有数据
@property (nonatomic,strong) NSMutableArray *otherKeys;//定义好友的键
@property (nonatomic,assign) BOOL isload;//判断好友列表在启动时,只从网上加载一次;
@property (nonatomic,strong) NSIndexPath *indexPath;//删除好友是用的indexPath;
@end
@implementation ContacterController
- (NSMutableArray *)keys{
    if (!_keys) {
        _keys = [NSMutableArray array];
    }
    return _keys;
}
- (NSMutableArray *)otherKeys{
    if (!_otherKeys) {
        _otherKeys = [NSMutableArray array];
    }
    return _otherKeys;
}
- (NSMutableDictionary *)datas{
    if (!_datas) {
        _datas = [NSMutableDictionary dictionary];
    }
    return _datas;
}
- (instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    //背景颜色  236 236 244   选中颜色208 208 208
    self.view.backgroundColor = LGColor(236, 236, 244);
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self setupFriendLabel];//添加标签
    [self setupRightButton];//导航按钮
    [self setupSearchBar];//添加搜索Bar;
    [self.tableView registerClass:[ContacterCell class] forCellReuseIdentifier:cellID];
    
}
#pragma mark 添加朋友标签
- (void)setupFriendLabel{
    //固定的数据
    //1.
    ContacterModel *modelOne = [ContacterModel new];
    modelOne.frendID = @"新的朋友";
    modelOne.headIcon = [UIImage imageNamed:@"plugins_FriendNotify"];
    modelOne.vcClass = [NewFriendViewController class];
    //2.
    ContacterModel *modelTwo = [ContacterModel new];
    modelTwo.frendID = @"群聊";
    modelTwo.headIcon = [UIImage imageNamed:@"add_friend_icon_addgroup"];
    modelTwo.vcClass = [ChatTogetherController class];
    //3.
    ContacterModel *modelThree = [ContacterModel new];
    modelThree.frendID = @"标签";
    modelThree.headIcon = [UIImage imageNamed:@"Contact_icon_ContactTag"];
    modelThree.vcClass = [ChatTogetherController class];
    
    NSArray *modelArr = @[modelOne,modelTwo,modelThree];
    [self.datas setObject:modelArr forKey:@"🔍"];
    [self.keys addObject:@"🔍"];
    
    
}
#pragma mark 设置右边导航条上的按钮
- (void)setupRightButton{
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"contacts_add_friend" highIcon:nil target:self action:@selector(rightClick)];
    
    
}
- (void)rightClick{
    
    AddFriendController *addFriendVc = [AddFriendController new];
    addFriendVc.title = @"添加朋友";
    [self.navigationController pushViewController:addFriendVc animated:YES];
    
}
#pragma mark 添加搜索栏
- (void)setupSearchBar{
    
    UISearchBar *search = [UISearchBar new];
    CGFloat searchX = 10;
    search.frame = CGRectMake(searchX, 5, ScreenWidth-searchX*2, 25);
    search.barStyle = UIBarStyleDefault;
    search.backgroundColor = [UIColor whiteColor];
    //实例化一个搜索栏  UITextInputTraits 的代理属性;
    //取消首字母大写
    search.autocapitalizationType = UITextAutocapitalizationTypeNone;
    search.autocorrectionType = UITextAutocorrectionTypeNo;
    
    search.placeholder = @"搜索";
    search.layer.borderWidth = 0;
    
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    searchView.backgroundColor = LGColorAlpha(189, 189, 195, 0.7);
    [searchView addSubview:search];
    
    self.tableView.tableHeaderView = searchView;
}
- (void)getFriendDatas{
    XMPPTools *tool = [XMPPTools sharedxmpp];
    //上下文 xmppRoster.vcdataModel
    NSManagedObjectContext *context = tool.rosterStorage.mainThreadManagedObjectContext;
    //请求数据
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    //筛选数据
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    fetch.sortDescriptors = @[sort];
    //执行查询数据
    /*
    NSError *error = nil;
    [context executeFetchRequest:fetch error:&error];
    NSLog(@"查询好友数据错误:%@",error);
     */
    _resultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetch managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    _resultsController.delegate = self;
    NSError *error = nil;
    [_resultsController performFetch:&error];
    if (error) {
       NSLog(@"查询好友数据错误:%@",error);
    }
    
    //如果数组中有值才调用这个方法
    if (_resultsController.fetchedObjects.count) {
        [self devideFriend];
        self.isload = YES;
    }
    
}
#pragma mark 给好友分区(在fetch的代理方中也执行这个方法)
- (void)devideFriend{
    
    XMPPTools *tool = [XMPPTools sharedxmpp];
    for (XMPPUserCoreDataStorageObject *user in _resultsController.fetchedObjects) {
        ContacterModel *friend = [ContacterModel new];
        friend.jid = user.jid;
        friend.frendID = [self cutString:user.jidStr];
        if (user.photo) {
            friend.headIcon = user.photo;
        }else{
            friend.headIcon = [UIImage imageWithData:[tool.avatar photoDataForJID:user.jid]];
        }
        
        friend.nickName = user.nickname;
        friend.vcClass = [ChatViewcontroller class];
        
        friend.py = [self hanZiPinYin:user.nickname];
        
        NSString *firstName = [[friend.py substringToIndex:1]uppercaseString];//取出第一个字母并变为大写
        
        //获取key所对应的数据(数组)
        NSArray *contacterArr = [self.datas objectForKey:firstName];
        NSMutableArray *contacter = nil;//临时数据
        if (!contacterArr) {
            contacter = [NSMutableArray arrayWithObject:friend];
        }else{
            
            contacter = [NSMutableArray arrayWithArray:contacterArr];
            [contacter addObject:friend];
        }
        
        [self.datas setObject:contacter forKey:firstName];
    }
  
    //获得所有的键
    for (NSString *keyStr in [self.datas allKeys]) {
        if (![keyStr isEqualToString:@"🔍"]) {
            [self.otherKeys addObject:keyStr];
        }
    }
    //遍历所有的键,除了固定的@"🔍",其他的key 保存到一个otherKeys,然后对otherKeys数组进行排序,然后保存起来;
    NSArray *k = [self.otherKeys sortedArrayUsingSelector:@selector(compare:)];
    
    [self.keys addObjectsFromArray:k];
    
}
#pragma mark 当请求好友的数据发生改变调用这个方法
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    if (!self.isload) {
        [self devideFriend];
        self.isload = YES;
    }
    [self.tableView reloadData];
}
#pragma mark 去掉@符号
- (NSString *)cutString:(NSString *)str{
    
    return [str componentsSeparatedByString:@"@"][0];
}
#pragma mark 把汉字转换为拼音
- (NSString *)hanZiPinYin:(NSString *)str{
    NSMutableString *customStr = [[NSMutableString alloc]initWithString:str];
    if (CFStringTransform((__bridge CFMutableStringRef)customStr, 0, kCFStringTransformMandarinLatin, NO)) {
        
        NSLog(@"PinYin:%@",customStr);//wǒ shì zhōng guó rén
    }
    if (CFStringTransform((__bridge CFMutableStringRef)customStr, 0, kCFStringTransformStripDiacritics, NO)) {
        //NSLog(@"Pingying: %@", ms); // wo shi zhong guo ren;
    }
    
    return customStr;
}
#pragma mark 开始滚动停止编辑
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.keys.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = [self.datas objectForKey:self.keys[section]];
    
    return arr.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    NSString *title = self.keys[section];
    return title;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContacterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NSString *key = self.keys[indexPath.section];
    ContacterModel *model = self.datas[key][indexPath.row];
    cell.contacterModel = model;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}
#pragma mark 返回标示图的索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return self.keys;
}
#pragma mark 点击cell的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *key = self.keys[indexPath.section];
    ContacterModel *model = self.datas[key][indexPath.row];
    if (model.vcClass) {
        UIViewController *vc = [model.vcClass new];
        
        if ([vc isKindOfClass:[ChatViewcontroller class]]) {
            
            ChatViewcontroller *chat = (ChatViewcontroller *)vc;
            chat.jid = model.jid;
            chat.photo = model.headIcon;
            [self.navigationController pushViewController:chat animated:YES];
            return;
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }
 
}
@end
