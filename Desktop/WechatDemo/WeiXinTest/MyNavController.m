//
//  MyNavController.m
//  WeiXinTest
//
//  Created by long on 16/5/17.
//  Copyright © 2016年 long. All rights reserved.
//

#import "MyNavController.h"

@implementation MyNavController
+ (void)initialize{
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage resizedImage:@"topbarbg_ios7"] forBarMetrics:UIBarMetricsDefault];
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    navBar.shadowImage = [UIImage new];//隐藏掉导航栏底部的那条线
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    item.tintColor = [UIColor whiteColor];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;//当push的时候隐藏底部栏
    }
    [super pushViewController:viewController animated:animated];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
@end
