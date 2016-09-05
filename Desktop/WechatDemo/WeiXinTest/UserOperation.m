//
//  UserOperation.m
//  WeiXinTest
//
//  Created by long on 16/5/17.
//  Copyright © 2016年 long. All rights reserved.
//

#import "UserOperation.h"
#import "MyNavController.h"
#import "MyTabBarController.h"
#import "LoginViewController.h"
@implementation UserOperation
SingletonM(user);
- (void)setUname:(NSString *)uname{
    [MyDefaults setObject:uname forKey:@"username"];
    [MyDefaults synchronize];
    
}
- (NSString *)uname{
    
    return [MyDefaults objectForKey:@"username"];
}
- (void)setPassword:(NSString *)password{
    
    [MyDefaults setObject:password forKey:@"password"];
    [MyDefaults synchronize];
}
- (NSString *)password{
    return [MyDefaults objectForKey:@"password"];
}
- (void)setLoginStatus:(BOOL)loginStatus{
    
    [MyDefaults setBool:loginStatus forKey:@"loginStatus"];
    [MyDefaults synchronize];
}

- (BOOL)loginStatus{
    
    return [MyDefaults boolForKey:@"loginStatus"];
}
+ (void)loginByStatus{
    
    UserOperation *user = [UserOperation shareduser];
#warning 测试用语
    user.loginStatus = YES;//用于测试;
    if (user.loginStatus) {
        
        XMPPTools *tools = [XMPPTools sharedxmpp];
        
        [tools login:nil];
        
        //登录
        
        MyTabBarController *tab = [MyTabBarController new];
        
     UIWindow *window  = [[UIApplication sharedApplication].delegate window];
        window.rootViewController = tab;
        
    }else{
        
        LoginViewController *login = [LoginViewController new];
        MyNavController *nav = [[MyNavController alloc]initWithRootViewController:login];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    }
}
@end
