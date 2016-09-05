//
//  HomeViewCell.m
//  WeiXinTest
//
//  Created by long on 16/5/24.
//  Copyright © 2016年 long. All rights reserved.
//

#import "HomeViewCell.h"
#import "HomeView.h"
#import "HomeModel.h"

@interface HomeViewCell ()
@property (nonatomic,weak) HomeView *homeView;
@end
@implementation HomeViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        //添加子视图
        [self setupChild];
        
    }
    return self;
}
- (void)setupChild{
    
    HomeView *hView = [[HomeView alloc]initWithFrame:self.bounds];
    [self.contentView addSubview:hView];
    self.homeView = hView;
    
}
- (void)setHomeModel:(HomeModel *)homeModel{
    self.homeView.homeModel = homeModel;
}
@end
