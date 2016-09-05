//
//  MeController.m
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import "MeController.h"
#import "TableCellItemModel.h"
#import "TableGroupModel.h"
#import "VCardController.h"
#import "SettingController.h"


#warning 由于me界面与discover相似,所以集成baseController.
@interface MeController ()
@property (nonatomic,weak) TableCellItemModel *userItem;
@end

@implementation MeController
- (void)viewDidLoad{
    [super viewDidLoad];
    //添加修改头像的通知
    [Mynotification addObserver:self selector:@selector(changeHeader:) name:changeHeadNameNotif object:nil];
    
    XMPPTools *tool = [XMPPTools sharedxmpp];
   XMPPvCardTemp *temp = tool.vCard.myvCardTemp;//得到user的网络名片
    //第一组
    TableGroupModel *groupOne = [TableGroupModel new];
    TableCellItemModel *user = [TableCellItemModel itemWithIcon:@"fts_default_headimage" title:@"用户" detailTitle:nil vcClass:[VCardController class]];
    user.image = temp.photo;
    groupOne.items = @[user];
    [self.datas addObject:groupOne];
    self.userItem = user;
    //第二组
    TableGroupModel *groupTwo = [TableGroupModel new];
    TableCellItemModel *photoAlbum = [TableCellItemModel itemWithIcon:@"MoreMyAlbum" title:@"相册" detailTitle:nil vcClass:nil];
    TableCellItemModel *collection = [TableCellItemModel itemWithIcon:@"MoreMyAlbum" title:@"收藏" detailTitle:nil vcClass:nil];
    TableCellItemModel *moneyBag = [TableCellItemModel itemWithIcon:@"MoreMyBankCard" title:@"钱包" detailTitle:nil vcClass:nil];
    groupTwo.items = @[photoAlbum,collection,moneyBag];
    [self.datas addObject:groupTwo];
    //第三组
    TableGroupModel *groupThree = [TableGroupModel new];
    TableCellItemModel *expression = [TableCellItemModel itemWithIcon:@"MoreExpressionShops" title:@"表情" detailTitle:nil vcClass:nil];
    groupThree.items = @[expression];
    [self.datas addObject:groupThree];
    //第四组
    TableGroupModel *groupFour = [TableGroupModel new];
    TableCellItemModel *setting = [TableCellItemModel itemWithIcon:@"MoreSetting" title:@"设置" detailTitle:@"账号为保护" vcClass:[SettingController class]];//跳转VC
    groupFour.items = @[setting];
    [self.datas addObject:groupFour];
    
    
}
#pragma mark 修改头像通知的事件
- (void)changeHeader:(NSNotification *)sender{
    
    NSData *data = [sender object];
    self.userItem.image = data;
    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
}
- (void)dealloc{
    
    [Mynotification removeObserver:self];
}
@end
