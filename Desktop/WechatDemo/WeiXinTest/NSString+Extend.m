//
//  NSString+Extend.m
//  WeiXinTest
//
//  Created by long on 16/5/18.
//  Copyright © 2016年 long. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)
//删除所有空格
- (NSString *)deleteSpace{
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
//编码url中的中文
- (NSString *)encodeUrlStr{
    NSString *encodePath = nil;
    
    if (!(IOS7_OR_LATER)) {
#ifndef IOS7_OR_LATER
    encodePath = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#endif
    }else{
    encodePath = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    }
    return encodePath;
}
@end
