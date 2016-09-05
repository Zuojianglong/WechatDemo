//
//  BaseMethod.h
//  WeiXinTest
//
//  Created by long on 16/5/18.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseMethod : NSObject
//显示信息
+(void)showMessage:(NSString*)message;
+(void)showMessage:(NSString*)message toView:(UIView*)View;
+(void)hideFormView:(UIView*)View;
+(void)hide;
//显示正确错误
+(void)showError:(NSString*)error;
+(void)showError:(NSString*)error toView:(UIView*)View;
+(void)showSuccess:(NSString*)success;
+(void)showSuccess:(NSString*)success toView:(UIView*)View;

//设置缓存图片
+(void)setCurrentImageView:(UIImageView*)imageView urlWithStr:(NSString*)urlString  placeholderImage:(UIImage*)placeholderImage;
//发生内存警告的时候清除内存图片
+(void)clearImageWhenReceiveMemoryWarning;
@end
