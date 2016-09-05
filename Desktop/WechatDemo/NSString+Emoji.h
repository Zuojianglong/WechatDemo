//
//  NSDate+Emoji.h
//  WeiXinTest
//
//  Created by long on 16/5/24.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

//表情的类别 对表情进行编码
@interface NSString (Emoji)
/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithIntCode:(long)intCode;
/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;

/**
 *  是否为emoji字符
 */
- (BOOL)isEmoji;
@end
