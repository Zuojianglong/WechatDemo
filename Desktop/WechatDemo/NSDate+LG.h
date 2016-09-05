//
//  NSDate+LG.h
//  WeiXinTest
//
//  Created by long on 16/5/23.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LG)
//判断是否为今天
-(BOOL)isToday;
//判断是否为昨天
-(BOOL)isYesterday;
//判断是否为今年
-(BOOL)isThisYear;
//获得与当前时间的差距
-(NSDateComponents *)deltaWithNow;

- (NSDate *)dateWithYMD;
@end
