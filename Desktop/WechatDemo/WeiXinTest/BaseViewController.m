//
//  BaseViewController.m
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import "BaseViewController.h"
#import "TableGroupModel.h"
#import "TableCellItemModel.h"
#import "DiscoverCell.h"

#define cell_ID @"discoverCell"
@implementation BaseViewController
- (instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}
- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(15, 0, 5, 0);
    self.tableView.backgroundColor = LGColor(236, 236, 244);
    
    [self.tableView registerClass:[DiscoverCell class] forCellReuseIdentifier:cell_ID];
    
}
#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.datas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   TableGroupModel *group = (TableGroupModel *)self.datas[section];
    
    return group.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_ID forIndexPath:indexPath];
    TableGroupModel *group = self.datas[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    TableGroupModel *group = self.datas[section];
    return group.header;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    TableGroupModel *group = self.datas[section];
    return group.footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 2;
}
#pragma mark 点击单元格执行的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableGroupModel *group = self.datas[indexPath.section];
    TableCellItemModel *item = group.items[indexPath.row];
    if (item.option) {
        item.option();//调用一下
    }else{
        if (!item.vcClass) {
            return;
        }
        [self.navigationController pushViewController:[item.vcClass new] animated:YES];
        
    }
    
}
@end
