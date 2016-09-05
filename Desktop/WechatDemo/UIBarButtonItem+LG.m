//
//  UIBarButtonItem+LG.m
//  WeiXinTest
//
//  Created by long on 16/5/21.
//  Copyright © 2016年 long. All rights reserved.
//

#import "UIBarButtonItem+LG.h"

@implementation UIBarButtonItem (LG)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton new];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);//让按钮的图片右偏移10
    [btn setImage:[UIImage resizedImage:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage resizedImage:highIcon] forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 20, btn.currentImage.size.width, btn.currentImage.size.height);
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
