//
//  UIImage+LG.m
//  WeiXinTest
//
//  Created by long on 16/5/18.
//  Copyright © 2016年 long. All rights reserved.
//

#import "UIImage+LG.h"

@implementation UIImage (LG)
+ (UIImage *)resizedImage:(NSString *)name{
    
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}
@end
