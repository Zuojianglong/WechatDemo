//
//  LGEmotion.m
//  WeiXinTest
//
//  Created by long on 16/5/24.
//  Copyright © 2016年 long. All rights reserved.
//

#import "LGEmotion.h"
#import "NSString+Emoji.h"
@implementation LGEmotion
- (NSString *)description{
    
    
    return [NSString stringWithFormat:@"%@ - %@ - %@",self.chs,self.png,self.code];
}
- (void)setCode:(NSString *)code{
    
    _code = code.copy;
    if (!code) {
        return;
    }
    self.emoji = [NSString emojiWithStringCode:code];
}
//判断是不是同一个表情
- (BOOL) isEqual:(LGEmotion *)otherEmotion{
    
    if (self.code) {//emoji表情
        
        return [self.code isEqualToString:otherEmotion.code];
        
    }else{
        //图片表情
        
        return [self.png isEqualToString:otherEmotion.png] && [self.chs isEqualToString:otherEmotion.chs] && [self.cht isEqualToString:otherEmotion.cht];
        
    }
    
    
}
#pragma mark 遵循nscoding协议
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.cht forKey:@"cht"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeObject:self.directory forKey:@"directory"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.chs = [aDecoder decodeObjectForKey:@"chs"];
        self.cht = [aDecoder decodeObjectForKey:@"cht"];
        self.png = [aDecoder decodeObjectForKey:@"png"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.directory = [aDecoder decodeObjectForKey:@"directory"];
        
        
    }
    return self;
}
@end
