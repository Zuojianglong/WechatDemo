//
//  MessageModel.m
//  WeiXinTest
//
//  Created by long on 16/5/25.
//  Copyright © 2016年 long. All rights reserved.
//

#import "MessageModel.h"
#import "LGRegexResult.h"
#import "LGEmotionAttAchment.h"
#import "LGEmotionTool.h"
@implementation MessageModel
- (void)setBody:(NSString *)body{
    _body = body.copy;
    [self createAttributedText];
    
}
- (void)createAttributedText{
    if (self.body ==nil) {
        return;
    }
    self.attributedBody = [self attributedStringWithText:self.body];
    
    
}
- (NSAttributedString *)attributedStringWithText:(NSString *)text{
    //匹配字符串
    NSArray *regexResults = [self regexResultsWithText:text];
    //根据匹配结果,拼接对应的图片表情与普通文本
    NSMutableAttributedString *attributedString = [NSMutableAttributedString new];
    [regexResults enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LGRegexResult *result = (LGRegexResult *)obj;
        LGEmotion *emotion = nil;
        if (result.isEmotion) {//是表情
            
            emotion = [LGEmotionTool emotionWithDesc:result.string];
        }
        if (emotion) {
            //如果有表情
            LGEmotionAttAchment *attach = [LGEmotionAttAchment new];
            //传递表情
            attach.emotion = emotion;
            attach.bounds = CGRectMake(0, -3, MyFont(16).lineHeight, MyFont(16).lineHeight);
            //将附件包装成富文本
            NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
            [attributedString appendAttributedString:attachString];
            
        }else{
            NSMutableAttributedString *subStr = [[NSMutableAttributedString alloc]initWithString:result.string];
            [attributedString appendAttributedString:subStr];
        }
        [attributedString addAttribute:NSFontAttributeName value:MyFont(16) range:NSMakeRange(0, attributedString.length)];
        
        
    }];
    return attributedString;
}
//
- (NSArray *)regexResultsWithText:(NSString *)text{
    //用于存放所有的匹配结果
    NSMutableArray *regexResults = [NSMutableArray array];
    //匹配表情
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        LGRegexResult *rr = [LGRegexResult new];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        rr.emotion = YES;
        [regexResults addObject:rr];
        
    }];
    
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        LGRegexResult *rr = [LGRegexResult new];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        rr.emotion = NO;
        [regexResults addObject:rr];

    }];
    //排序
    [regexResults sortUsingComparator:^NSComparisonResult(LGRegexResult *obj1, LGRegexResult *obj2) {
        NSInteger loc1 = obj1.range.location;
        NSInteger loc2 = obj2.range.location;
        return [@(loc1)compare:@(loc2)];
    }];
    
    return regexResults;
}
@end
