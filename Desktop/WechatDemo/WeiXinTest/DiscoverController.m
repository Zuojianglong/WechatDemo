//
//  DiscoverController.m
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import "DiscoverController.h"
#import "TableGroupModel.h"
#import "TableCellItemModel.h"

@interface DiscoverController ()

@end

@implementation DiscoverController
- (void)viewDidLoad{
    [super viewDidLoad];
    //第一组
    TableCellItemModel *friend = [TableCellItemModel itemWithIcon:@"AlbumReflashIcon" title:@"朋友圈" detailTitle:nil vcClass:nil];
    friend.option = ^{
    //操作
    };
    TableGroupModel *groupOne = [TableGroupModel new];
    groupOne.items = @[friend];
    [self.datas addObject:groupOne];
    
    //第二组
    TableCellItemModel *clear = [TableCellItemModel itemWithIcon:@"ff_IconQRCode" title:@"扫一扫" detailTitle:nil vcClass:nil];
    TableCellItemModel *shake = [TableCellItemModel itemWithIcon:@"ff_IconShake" title:@"摇一摇" detailTitle:nil vcClass:nil];
    TableGroupModel *groupTwo = [TableGroupModel new];
    groupTwo.items = @[clear,shake];
    [self.datas addObject:groupTwo];
    
    //第三组
    TableCellItemModel *LookAround = [TableCellItemModel itemWithIcon:@"ff_IconLocationService" title:@"附近的人" detailTitle:nil vcClass:nil];
    TableCellItemModel *bottle = [TableCellItemModel itemWithIcon:@"ff_IconBottle" title:@"漂流瓶" detailTitle:nil vcClass:nil];
    TableGroupModel *groupThree = [TableGroupModel new];
    groupThree.items = @[LookAround,bottle];
    [self.datas addObject:groupThree];
    
    //第四组
    TableCellItemModel *shop = [TableCellItemModel itemWithIcon:@"CreditCard_ShoppingBag" title:@"购物" detailTitle:@"淘宝商城" vcClass:nil];
    TableCellItemModel *game = [TableCellItemModel itemWithIcon:@"MoreGame" title:@"游戏" detailTitle:nil vcClass:nil];
    TableGroupModel *groupFour = [TableGroupModel new];
    groupFour.items = @[shop,game];
    [self.datas addObject:groupFour];
    
    
}
@end
