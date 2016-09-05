//
//  SettingViewCell.m
//  WeiXinTest
//
//  Created by long on 16/5/21.
//  Copyright © 2016年 long. All rights reserved.
//

#import "SettingViewCell.h"
#import "SettingModel.h"
#import "SettingView.h"

@interface SettingViewCell ()
@property (nonatomic,weak) SettingView *settingView;
@end

@implementation SettingViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加view;
        
        [self setupSubview];
    }
    return self;
}
- (void)setupSubview{
    SettingView *setting = [[SettingView alloc]initWithFrame:self.frame];
    
    [self.contentView addSubview:setting];
    self.settingView = setting;
    
    
}
#pragma mark 属性
- (void)setSettingModel:(SettingModel *)settingModel{
    
    _settingModel = settingModel;
    
    self.settingView.settingModel = settingModel;
    
}
//可用可不用(现在这个方法没有实现)
#pragma mark 初始化方法
+ (instancetype)cellWithTableView:(UITableView *)table indexPath:(NSIndexPath *)indexPath indentifier:(NSString *)indentifier{
    
    SettingViewCell *cell = [table dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    
    
    return cell;
}
@end
