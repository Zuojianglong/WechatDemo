//
//  DiscoverCell.m
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import "DiscoverCell.h"
#import "TableCellItemModel.h"
#import "DiscoverView.h"

@interface DiscoverCell ()
@property (nonatomic,weak) DiscoverView *Dview;
@end

@implementation DiscoverCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加子视图
        [self setupSubView];
    }
    
    return self;
}
-(void)setupSubView{
    
    DiscoverView *discView = [[DiscoverView alloc]initWithFrame:self.bounds];
    self.Dview = discView;
    [self.contentView addSubview:discView];
    
}
- (void)setItem:(TableCellItemModel *)item{
    _item = item;
    self.Dview.item = item;
    
    
}
@end
