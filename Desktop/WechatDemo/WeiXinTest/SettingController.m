//
//  SettingController.m
//  WeiXinTest
//
//  Created by long on 16/5/20.
//  Copyright © 2016年 long. All rights reserved.
//

#import "SettingController.h"
#import "SettingModel.h"
#import "SettingViewCell.h"
#import "MyNavController.h"
#import "LoginViewController.h"

#define CELL_ID @"setttingCell"
@interface SettingController ()
@property (nonatomic,strong) NSMutableArray *allDatas;
@end
@implementation SettingController
- (instancetype)init{
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
    
}
- (NSMutableArray *)allDatas{
    if (!_allDatas) {
        _allDatas = [NSMutableArray array];
    }
    return _allDatas;
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = LGColor(236, 236, 244);
    self.tableView.contentInset = UIEdgeInsetsMake(15, 0, 5, 0);
    self.title = @"设置";
    
    //添加数据
    [self addModel];
    
    [self.tableView registerClass:[SettingViewCell class] forCellReuseIdentifier:CELL_ID];
    
    
}
- (void)addModel{
    
    SettingModel *account = [SettingModel settingWithTitle:@"账号安全" detailTitle:@"未保护"];
    NSArray *oneArr = @[account];
    [self.allDatas addObject:oneArr];
    //2.
    SettingModel *newMsg=[SettingModel settingWithTitle:@"新消息通知" detailTitle:nil];
    SettingModel *conseal=[SettingModel settingWithTitle:@"隐私" detailTitle:nil];
    SettingModel *common=[SettingModel settingWithTitle:@"通用" detailTitle:nil];
    NSArray *twoArr=@[newMsg,conseal,common];
    [self.allDatas addObject:twoArr];
    //3.
    SettingModel *abount=[SettingModel settingWithTitle:@"新消息通知" detailTitle:nil];
    NSArray *threeArr=@[abount];
    [self.allDatas addObject:threeArr];
    //4.
    SettingModel *loginOut=[SettingModel settingWithTitle:@"退出登录" detailTitle:nil];
    loginOut.isLoginOut=YES;
    NSArray *fourArr=@[loginOut];
    [self.allDatas addObject:fourArr];
    
    
}
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return self.allDatas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = self.allDatas[section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    SettingModel *model = self.allDatas[indexPath.section][indexPath.row];
    cell.settingModel = model;
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 2;
}
#pragma mark 点击cell执行的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     SettingModel *model = self.allDatas[indexPath.section][indexPath.row];
    //退出登录的操作
    if (model.isLoginOut) {
        XMPPTools *tool = [XMPPTools sharedxmpp];
        [tool xmppLoginOut];//退出;
        //跳转窗口
        [self dismissViewControllerAnimated:YES completion:nil];
        LoginViewController * loginVc = [LoginViewController new];
        MyNavController *nav = [[MyNavController alloc ]initWithRootViewController:loginVc];
        
        self.view.window.rootViewController = nav;
        
    }
    
    
}
@end
