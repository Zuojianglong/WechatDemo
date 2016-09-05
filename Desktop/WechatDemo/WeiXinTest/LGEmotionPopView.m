//
//  HMEmotionPopView.m
//  黑马微博
//
//  Created by apple on 14-7-17.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "LGEmotionPopView.h"
#import "LGEmotionView.h"

@interface LGEmotionPopView()
@property (weak, nonatomic) IBOutlet LGEmotionView *emotionView;
@end

@implementation LGEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LGEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFromEmotionView:(LGEmotionView *)fromEmotionView
{
    if (fromEmotionView == nil) return;
    
    // 1.显示表情
    self.emotionView.emotion = fromEmotionView.emotion;
    
    // 2.添加到窗口上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 3.设置位置
    CGFloat centerX = fromEmotionView.centerX;
    CGFloat centerY = fromEmotionView.centerY - self.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

/**
 *  当一个控件显示之前会调用一次（如果控件在显示之前没有尺寸，不会调用这个方法）
 *
 *  @param rect 控件的bounds
 */
- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"emoticon_keyboard_magnifier"] drawInRect:rect];
}
@end
