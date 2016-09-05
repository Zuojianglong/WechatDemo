//
//  SendTextView.h
//  WeiXinTest
//
//  Created by long on 16/5/24.
//  Copyright © 2016年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LGEmotion;
@interface SendTextView : UITextView
/**
 *  拼接表情到最后面
 */
- (void)appendEmotion:(LGEmotion *)emotion;

/**
 *  具体的文字内容
 */
- (NSString *)realText;

@end
