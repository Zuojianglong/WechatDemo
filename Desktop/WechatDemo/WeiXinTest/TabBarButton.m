//
//  TabBarButton.m
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import "TabBarButton.h"
#import "BadgeView.h"

#define TabBarButtonImageRatio 0.65 //图片的缩放比例
@interface TabBarButton ()
@property (nonatomic,weak) BadgeView *badgeView;
@end
@implementation TabBarButton
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = MyFont(11);
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:LGColor(26, 178, 10) forState:UIControlStateSelected];
        BadgeView *badge = [BadgeView new];
        badge.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:badge];
        self.badgeView = badge;
        
    }
    
    return self;
}
#pragma mark 设置button的子视图 view与title的所在的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = contentRect.size.width;//得到图片的宽度
    CGFloat imageH = contentRect.size.height*TabBarButtonImageRatio;
    
    return CGRectMake(0, 0, imageW, imageH);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat titleW = contentRect.size.width;
    CGFloat titleY = contentRect.size.height*TabBarButtonImageRatio;
    CGFloat titleH = contentRect.size.height-titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
}
#pragma mark 设置item
- (void)setItem:(UITabBarItem *)item{
    _item = item;
    //KVO  监听属性的改变
    
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    //设置默认的按钮颜色
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    [self setTitle:item.title forState:UIControlStateNormal];
    
    self.badgeView.badgeValue = item.badgeValue;
    self.badgeView.top = -2;
    CGFloat badgeX = 0;
    //6p
    if (ScreenWidth>375) {
        badgeX = self.width-self.badgeView.width-20;
    }else if (ScreenWidth>320){//6
        
        badgeX = self.width-self.badgeView.width-15;
    }else{//5
        
        badgeX=self.width-self.badgeView.width-10;
    }
    self.badgeView.left = badgeX;
    
    
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    //添加提醒数字按钮
    self.badgeView.badgeValue=self.item.badgeValue;
    self.badgeView.top=0;
    
    CGFloat badgeX=0;
    if(ScreenWidth>375){
        badgeX=self.width-self.badgeView.width-20;
    }else if(ScreenWidth>320){  //iPhone 6
        badgeX=self.width-self.badgeView.width-15;
    }else{   //iphone 4-5s的宽度
        badgeX=self.width-self.badgeView.width-10;
    }
    
    self.badgeView.left=badgeX;
    
    
}
- (void)dealloc{
   
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    [self.item removeObserver:self forKeyPath:@"title"];
    
    
}
@end
