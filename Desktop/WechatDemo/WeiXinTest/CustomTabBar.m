//
//  CustomTabBar.m
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import "CustomTabBar.h"
#import "TabBarButton.h"
@interface CustomTabBar ()
@property (nonatomic,strong) NSMutableArray *buttons;
@property (nonatomic,weak) TabBarButton *tabButton;
@end

@implementation CustomTabBar
- (NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray arrayWithCapacity:5];
    }
    return _buttons;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor redColor];
        
        
    }
    
    return self;
}
- (void)addTabBarButtonItem:(UITabBarItem *)item{
    //添加按钮
    TabBarButton *tabBtn = [TabBarButton new];
    [self addSubview:tabBtn];
    [self.buttons addObject:tabBtn];
    tabBtn.item =item;
    [tabBtn addTarget:self action:@selector(tabBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //默认选中第一个
    if (self.buttons.count ==1) {
        [self tabBtnClick:tabBtn];
    }
    
}
#pragma mark 点击tabbar按钮的事件
- (void)tabBtnClick:(TabBarButton *)sender{

    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.tabButton.tag to:sender.tag];
    }
    self.tabButton.selected = NO;
    sender.selected = YES;
    self.tabButton = sender;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnW = self.width/self.buttons.count;
    CGFloat btnH = self.height;
    CGFloat btnY = 0;
    for (int i = 0; i <self.buttons.count; i++) {
        TabBarButton *tabBtn = self.buttons[i];
        tabBtn.tag = i;
        CGFloat btnX = i*btnW;
        
        tabBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
}
@end
