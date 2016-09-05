//
//  HomeModel.m
//  WeiXinTest
//
//  Created by long on 16/5/23.
//  Copyright © 2016年 long. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
//设置时间
- (NSString *)time{
    
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
#warning 真机调试加上这句话
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *createDate = [df dateFromString:_time];
    
    //判断时间是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) {//判断时候为今天
            
            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >=1 ) {//至少是发布一个小时
                return [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
            }else if (cmps.minute >= 1){//1-59分钟
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
            }else{
                return @"刚刚";
            }
        }else if (createDate.isThisYear){
            df.dateFormat = @"昨天 HH:mm";
            return [df stringFromDate:createDate];
        }else{
            
            df.dateFormat = @"yyyy-MM-dd HH:mm";
            return [df stringFromDate:createDate];
        }
    }else{//往年
        df.dateFormat=@"yyyy-MM-dd";
        return [df stringFromDate:createDate];
    }
 
}
#pragma mark  设置小红点
- (void)setBadgeValue:(NSString *)badgeValue{
    //如果大于99 变为99+
    int count = badgeValue.intValue;
    if (count>99) {
        _badgeValue = [NSString stringWithFormat:@"99+"];
    }else{
        
        _badgeValue = badgeValue;
    }
    
}
@end
