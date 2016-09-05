//
//  HomeView.m
//  WeiXinTest
//
//  Created by long on 16/5/24.
//  Copyright © 2016年 long. All rights reserved.
//

#import "HomeView.h"
#import "HomeModel.h"
#import "BadgeView.h"


#define marginLeft 10
#define headWidth  40
#define headHeight headWidth
@interface HomeView ()
@property (nonatomic,weak) UIImageView *head;//头像
@property (nonatomic,weak) UILabel *titleLabel;//title
@property (nonatomic,weak) UILabel *subTitleLabel;//内容
@property (nonatomic,weak) UILabel *timeLabel;//时间
@property (nonatomic,weak) BadgeView *badgeButton;//数字提醒按钮
@end
@implementation HomeView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self setupView];
    }
    
    return self;
}
- (void)setupView{
    //头像
    UIImageView *head = [UIImageView new];
    head.frame = CGRectMake(marginLeft, marginLeft, headWidth, headHeight);
    head.layer.cornerRadius = 5.0f;
    head.layer.masksToBounds = YES;
    [self addSubview:head];
    self.head = head;
    //title
    UILabel *titleLab = [UILabel new];
    titleLab.font = MyFont(17);
    titleLab.textColor = [UIColor blackColor];
    [self addSubview:titleLab];
    self.titleLabel = titleLab;
    //内容
    UILabel *subTitle = [UILabel new];
    subTitle.font = MyFont(14);
    subTitle.textColor = [UIColor lightGrayColor];
    [self addSubview:subTitle];
    self.subTitleLabel = subTitle;
    //时间
    UILabel *timeLabel = [UILabel new];
    timeLabel.font = MyFont(12);
    timeLabel.textColor = [UIColor lightTextColor];
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    //小红点
    BadgeView *badgeBtn = [BadgeView new];
    [self addSubview: badgeBtn];
    self.badgeButton = badgeBtn;
    
}
#pragma mark 传递模型
- (void)setHomeModel:(HomeModel *)homeModel{
    
    _homeModel = homeModel;
    //头像
    self.head.image = homeModel.headerIcon?[UIImage imageWithData:homeModel.headerIcon]:[UIImage imageNamed:@"DefaultProfileHead_phone"];
    //用户名
    CGFloat nameX = self.head.right+marginLeft;
    CGFloat nameY = marginLeft;
    CGSize nameS = [homeModel.uname sizeWithAttributes:@{NSFontAttributeName:MyFont(17)}];
    self.titleLabel.frame = CGRectMake(nameX, nameY, nameS.width, nameS.height);
    self.titleLabel.text = homeModel.uname;
    //设置聊天body
    CGFloat bodyY = self.titleLabel.buttom;
    CGFloat bodyX = nameX;
    CGFloat bodyH = 20;
    CGFloat bodyW = ScreenWidth-bodyX-marginLeft*2;
    self.subTitleLabel.frame = CGRectMake(bodyX, bodyY, bodyW, bodyH);
    self.subTitleLabel.text = homeModel.body;
    //设置时间
    CGSize timeS = [homeModel.time sizeWithAttributes:@{NSFontAttributeName:MyFont(12)}];
    CGFloat timeX = ScreenWidth-timeS.width-marginLeft;
    CGFloat timeY = marginLeft;
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeS.width, timeS.height);
    self.timeLabel.text = homeModel.time;
    //设置提示按钮
    if (homeModel.badgeValue.length>0 && ![homeModel.badgeValue isEqualToString:@""]) {
        self.badgeButton.badgeValue = homeModel.badgeValue;
        self.badgeButton.hidden = NO;
        
        CGFloat badgeX = self.head.right-self.badgeButton.width*0.5;
        CGFloat badgeY = 0;
        self.badgeButton.left = badgeX;
        self.badgeButton.top = badgeY;
        
    }else{
        
        self.badgeButton.hidden = YES;
    }
    
}
@end
