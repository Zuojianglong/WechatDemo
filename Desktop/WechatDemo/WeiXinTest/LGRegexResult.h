//
//  LGRegexResult.h
//  WeiXinTest
//
//  Created by long on 16/5/24.
//  Copyright © 2016年 long. All rights reserved.
//
//用来封装一个匹配结果
#import <Foundation/Foundation.h>

@interface LGRegexResult : NSObject
/**
 *  匹配到的字符串
 */
@property (nonatomic,copy) NSString *string;
/**
 *  匹配到的范围
 */
@property (nonatomic,assign) NSRange range;
/**
 *  这个结果是否为表情
 */
@property (nonatomic,assign,getter=isEmotion) BOOL emotion;
@end
