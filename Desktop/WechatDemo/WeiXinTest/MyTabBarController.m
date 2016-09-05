//
//  MyTabBarController.m
//  WeiXinTest
//
//  Created by long on 16/5/17.
//  Copyright © 2016年 long. All rights reserved.
//

#import "MyTabBarController.h"
#import "MyNavController.h"
#import "CustomTabBar.h"
#import "HomeViewcontroller.h"
#import "ContacterController.h"
#import "DiscoverController.h"
#import "MeController.h"
@interface MyTabBarController ()<CustomTabBarDelegate>
@property (nonatomic,strong) CustomTabBar *customTabBar;
@property (nonatomic,strong) HomeViewcontroller *home;
@property (nonatomic,strong) ContacterController *contacter;
@property (nonatomic,strong) DiscoverController *discover;
@property (nonatomic,strong) MeController *me;
@end
@implementation MyTabBarController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:[UIControl class]]) {
            
            [subView removeFromSuperview];//移除原来的tab的按钮
            
        }
    }
    
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupTabBar];//设置自定义TabBar
    [self setupChildControllers];
}
- (void)setupTabBar{

    
    
    CustomTabBar *tabBar = [CustomTabBar new];
    tabBar.delegate = self;
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    
    self.customTabBar = tabBar;
    
    
}
#pragma mark 实现自定义标签的视图的代理方法
- (void)tabBar:(CustomTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to{
    self.selectedIndex = to;
}
- (void)setupChildControllers{
    
    //1.首页
    HomeViewcontroller *home=[[HomeViewcontroller alloc]init];
    self.home=home;
     home.tabBarItem.badgeValue=@"9";
    [self setupChildViewController:home title:@"微信" imageName:@"tabbar_mainframe" selectedImageName:@"tabbar_mainframeHL"];
    //2.通讯录
    ContacterController *contacter=[[ContacterController alloc]init];
    self.contacter=contacter;
   // contacter.tabBarItem.badgeValue=@"78";
    [self setupChildViewController:contacter title:@"通讯录" imageName:@"tabbar_contacts" selectedImageName:@"tabbar_contactsHL"];
    //3.发现
    DiscoverController *discover=[[DiscoverController alloc]init];
    //self.discover=discover;
    discover.tabBarItem.badgeValue=@"1000";
    [self setupChildViewController:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discoverHL"];
    //4.我
    MeController *me=[[MeController alloc]init];
    //me.tabBarItem.badgeValue=@"8";
    self.me=me;
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_me" selectedImageName:@"tabbar_meHL"];
    
    
    
}
#pragma mark 添加子视图控制器
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    MyNavController *nav = [[MyNavController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    [self.customTabBar addTabBarButtonItem:childVc.tabBarItem];
    
    
    
    
}
//浅色状态栏
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
@end
