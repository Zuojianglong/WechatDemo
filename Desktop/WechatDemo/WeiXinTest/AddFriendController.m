//
//  AddFriendController.m
//  WeiXinTest
//
//  Created by long on 16/5/22.
//  Copyright © 2016年 long. All rights reserved.
//

#import "AddFriendController.h"
#import "AddfriendCell.h"
#import "MyTextField.h"

#define cellID @"AddfriendCell"
@interface AddFriendController ()
@property (nonatomic,weak) MyTextField *myText;;
@end

@implementation AddFriendController
- (instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self addRightBarButton];
    
    [self.tableView registerClass:[AddfriendCell class] forCellReuseIdentifier:cellID];
    
    
}
#pragma mark 添加右导航按钮
- (void)addRightBarButton{
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(0, 0, 30, 40);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    btn.titleLabel.font = MyFont(15);
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}
- (void)addFriend{
    
    NSString *uname = self.myText.text.deleteSpace.lowercaseString;
    if ([uname isEqualToString:@""]) {
        return;
    }
    //添加好友
    
    XMPPTools *tool = [XMPPTools sharedxmpp];
    XMPPJID *jid = [XMPPJID jidWithUser:uname domain:ServerName resource:nil];
    
    //判断是否为自己
    UserOperation *user = [UserOperation shareduser];
    if ([user.uname isEqualToString:uname]) {
        [self showMessage:@"不能添加自己为好友!"];
        return;
    }
    if ([tool.rosterStorage userExistsWithJID:jid xmppStream:tool.xmppStream]) {
        [self showMessage:@"此用户已经是你的好友了"];
        return;
    }
    [tool.roster subscribePresenceToUser:jid];
    
   // [BaseMethod showError:@"此模块正在开发中..."];
    
}
- (void)showMessage:(NSString *)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddfriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    self.myText = cell.textField;
    
    return cell;
    
}
@end
