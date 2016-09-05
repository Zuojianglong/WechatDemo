//
//  NSDate+LG.m
//  WeiXinTest
//
//  Created by long on 16/5/23.
//  Copyright © 2016年 long. All rights reserved.
//

#import "NSDate+LG.h"

@implementation NSDate (LG)
- (BOOL)isToday{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    //获取当前的时间
    NSDateComponents *nowCmps =[calendar components:unit fromDate:[NSDate date]];
    //获取self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return (selfCmps.year == nowCmps.year)&&(selfCmps.month ==nowCmps.month)&&(selfCmps.day == nowCmps.day);
    
}
//判断是否为昨天
- (BOOL)isYesterday{
    
    NSDate *nowDate = [[NSDate date]dateWithYMD];
    NSDate *selfDate = [self dateWithYMD];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
    
}
//是否为今年
- (BOOL)isThisYear{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps == selfCmps;
}
//返回消息发布时间到现在时间的差距  时分秒
- (NSDateComponents *)deltaWithNow{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}
#pragma mark 返回Y-M-D
- (NSDate *)dateWithYMD{
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd";
    NSString *timeStr = [df stringFromDate:self];
    
    return [df dateFromString:timeStr];
}
@end
