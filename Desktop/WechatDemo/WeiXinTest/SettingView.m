//
//  SettingView.m
//  WeiXinTest
//
//  Created by long on 16/5/21.
//  Copyright © 2016年 long. All rights reserved.
//

#import "SettingView.h"
#import "SettingModel.h"

#define marginLeft 10
@interface SettingView ()
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UILabel *detailTitle;
@property (nonatomic,weak) UIButton *arrow;
@end
@implementation SettingView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        //添加view
        [self setupSubview];
    }
    
    return self;
}
- (void)setupSubview{
    UILabel *title = [UILabel new];
    title.font = MyFont(17);
    title.textColor = [UIColor blackColor];
    [self addSubview:title];
    self.title = title;
    //2.添加详细标题
    UILabel *detailTitle=[[UILabel alloc]init];
    detailTitle.font=MyFont(15);
    detailTitle.textColor=[UIColor lightGrayColor];
    [self addSubview:detailTitle];
    detailTitle.hidden=YES;
    self.detailTitle=detailTitle;
    //3.箭头
    UIButton *arrow = [UIButton new];
    CGFloat arrowW = 20;
    CGFloat arrowH = arrowW;
    CGFloat arrowY = (self.height-arrowH)*0.5;
    CGFloat arrowX = ScreenWidth-arrowW-marginLeft;
    arrow.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);
    arrow.userInteractionEnabled = NO;
    [arrow setImage:[UIImage resizedImage:@"pay_arrowright"] forState:UIControlStateNormal];
    [self addSubview:arrow];
    self.arrow = arrow;
    
}
- (void)setSettingModel:(SettingModel *)settingModel{
    
    _settingModel = settingModel;
    
    CGSize titleSize = [settingModel.title sizeWithAttributes:@{NSFontAttributeName:MyFont(17)}];
    CGFloat titleX = 0;
    if (settingModel.isLoginOut) {
        titleX = (ScreenWidth-titleSize.width)*0.5;
        self.arrow.hidden = YES;
    }else{
        
        titleX = marginLeft;
    }
    CGFloat titleY = (self.height - titleSize.height)*0.5;
    self.title.frame = CGRectMake(titleX, titleY, titleSize.width, titleSize.height);
    //计算detailTitle
    if (settingModel.detailTitle.length > 0) {
        self.detailTitle.hidden = NO;
        CGSize detailSize = [settingModel.detailTitle sizeWithAttributes:@{NSFontAttributeName:MyFont(15)}];
        CGFloat detailX = ScreenWidth-detailSize.width-self.arrow.width-marginLeft;
        CGFloat detailY = (self.height-detailSize.height)*0.5;
        self.detailTitle.frame = CGRectMake(detailX, detailY, detailSize.width, detailSize.height);
    }
    
    self.title.text = settingModel.title;
    self.detailTitle.text = settingModel.detailTitle;
    
    
}
@end
