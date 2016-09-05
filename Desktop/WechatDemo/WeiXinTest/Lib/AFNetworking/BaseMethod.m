//
//  BaseMethod.m
//  WeiXinTest
//
//  Created by long on 16/5/18.
//  Copyright © 2016年 long. All rights reserved.
//

#import "BaseMethod.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#import "AFNetworking.h"
@implementation BaseMethod
//hud 的封装
+ (void)showMessage:(NSString *)message{
    
    [MBProgressHUD showMessage:message];
}
+ (void)showMessage:(NSString *)message toView:(UIView *)view{
    [MBProgressHUD showMessage:message toView:view];
}
+ (void)hide{
    [MBProgressHUD hideHUD];
}
+ (void)hideFormView:(UIView *)view{
    
    [MBProgressHUD hideHUDForView:view animated:YES];
}
//hud显示 的是否为正确
+ (void)showError:(NSString *)error{
    [MBProgressHUD showError:error];
    
}
+ (void)showError:(NSString *)error toView:(UIView *)view{
    
    [MBProgressHUD showError:error toView:view];
}
+ (void)showSuccess:(NSString *)success{
    
    [MBProgressHUD showSuccess:success];
    
}
+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    
    [MBProgressHUD showSuccess:success toView:view];
}
//设置缓存图片
+ (void)setCurrentImageView:(UIImageView *)imageView urlWithStr:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage{
    
    NSString *newUrlStr = urlString.encodeUrlStr;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:newUrlStr] placeholderImage:placeholderImage];
}
+ (void)clearImageWhenReceiveMemoryWarning{
    //停止下载
    [[SDWebImageManager sharedManager] cancelAll];
    //移除下载到内存中的图片
    [[SDImageCache sharedImageCache]clearMemory];
    
}
@end
