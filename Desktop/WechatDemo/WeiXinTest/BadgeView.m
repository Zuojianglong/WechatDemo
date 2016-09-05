//
//  BadgeView.m
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import "BadgeView.h"

@implementation BadgeView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.titleLabel.font = MyFont(11);
        [self setBackgroundImage:[UIImage resizedImage:@"tabbar_badge"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
        
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    
    _badgeValue = badgeValue.copy;
    if (badgeValue && ![badgeValue isEqualToString:@"0"]) {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        if (badgeValue.length>1) {
            CGSize btnSize = [badgeValue sizeWithAttributes:@{NSFontAttributeName:MyFont(11)}];
            self.width = btnSize.width+20;
            self.height = self.currentBackgroundImage.size.height;
        }else{
            self.width = self.currentBackgroundImage.size.width;
            self.height = self.currentBackgroundImage.size.height;
            
        }
        
    }else{
        self.hidden = YES;
    }
    
    
}
@end
