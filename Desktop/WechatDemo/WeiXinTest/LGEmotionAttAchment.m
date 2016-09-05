//
//  LGEmotionAttAchment.m
//  WeiXinTest
//
//  Created by long on 16/5/24.
//  Copyright © 2016年 long. All rights reserved.
//

#import "LGEmotionAttAchment.h"
#import "LGEmotion.h"
@implementation LGEmotionAttAchment
- (void)setEmotion:(LGEmotion *)emotion{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",emotion.directory,emotion.png]];
}
@end
