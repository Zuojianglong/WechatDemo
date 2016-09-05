//
//  UIView+FrameExtend.m
//  JiSuanFrame
//
//  Created by long on 16/5/9.
//  Copyright © 2016年 long. All rights reserved.
//

#import "UIView+FrameExtend.h"
#import <objc/runtime.h>


@implementation UIView (FrameExtend)
////////////////////////////////////--->left
- (CGFloat)left{
    
    
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)left{
    
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}
////////////////////////////////////--->top
- (CGFloat)top{
    
   return self.frame.origin.y;
    
}
- (void)setTop:(CGFloat)top{
    
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
    
}
///////////////////////////////////--->right
- (CGFloat)right{
    
    return self.frame.origin.x+self.frame.size.width;
    
}
- (void)setRight:(CGFloat)right{
    
    CGRect frame = self.frame;
    frame.origin.x = right-frame.size.width;
    self.frame = frame;
}
///////////////////////////////////--->buttom
- (CGFloat)buttom{
    
    return self.frame.origin.y+self.frame.size.height;
    
}
- (void)setButtom:(CGFloat)buttom{
    
    CGRect frame = self.frame;
    frame.origin.y = buttom-frame.size.height;
    self.frame = frame;
    
}
///////////////////////////////////--->centerX
- (CGFloat)centerX{
    
    return self.center.x;
    
}
- (void)setCenterX:(CGFloat)centerX{
    
    self.center = CGPointMake(centerX, self.center.y);
    
}
///////////////////////////////////--->centerY
- (CGFloat)centerY{
    
    return self.center.y;
    
}
- (void)setCenterY:(CGFloat)centerY{
    
    self.center = CGPointMake(self.center.x, centerY);
    
}
///////////////////////////////////--->width
- (CGFloat)width {
    
    return self.frame.size.width;
    
}
- (void)setWidth:(CGFloat)width {
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
}
///////////////////////////////////--->height
- (CGFloat)height {
    
    return self.frame.size.height;
    
}

- (void)setHeight:(CGFloat)height {
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
}
///////////////////////////////////--->origin
- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
///////////////////////////////////--->size
- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
@end

