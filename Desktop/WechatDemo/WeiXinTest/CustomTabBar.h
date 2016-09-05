//
//  CustomTabBar.h
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTabBar;
@protocol CustomTabBarDelegate <NSObject>
@optional
- (void)tabBar:(CustomTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

@end
@interface CustomTabBar : UIView
@property (nonatomic,weak) id<CustomTabBarDelegate> delegate;
-(void)addTabBarButtonItem:(UITabBarItem *)item;
@end
