//
//  SendTextView.m
//  WeiXinTest
//
//  Created by long on 16/5/24.
//  Copyright © 2016年 long. All rights reserved.
//

#import "SendTextView.h"
#import "LGEmotion.h"
#import "LGEmotionAttAchment.h"
@implementation SendTextView
- (instancetype)init{
    self = [super init];
    if (self) {
        
        //
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.5f;
        self.layer.cornerRadius = 5.0f;
        self.returnKeyType = UIReturnKeySend;
        self.enablesReturnKeyAutomatically = YES;//设置键盘自动判断有没有文本;
        self.font = MyFont(16);
        
    }
    
    return self;
}
- (void)appendEmotion:(LGEmotion *)emotion{
    if (emotion.emoji) {
        [self insertText:emotion.emoji];
    }else{
        //图片表情
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
        //创建一个富文本可以带图片的
        LGEmotionAttAchment *attach = [LGEmotionAttAchment new];
        attach.emotion = emotion;
        attach.bounds = CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight);
        NSAttributedString *attachStr = [NSAttributedString attributedStringWithAttachment:attach];
        //记录表情插入的位置
        NSInteger insertIndex = self.selectedRange.location;
        //插入表情图片到光标位置
        [attributeString insertAttributedString:attachStr atIndex:insertIndex];
        [attributeString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributeString.length)];
        //重新赋值(光标会自动回到文字的最后面)
        self.attributedText = attributeString;
        //让光标回到表情的后面
        self.selectedRange = NSMakeRange(insertIndex+1, 0);
        
    }
    
    
}
- (NSString *)realText{
    //用来拼接所有的文字
    NSMutableString *string = [NSMutableString string];
    //遍历富文本里面的所有内容
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        LGEmotionAttAchment *attach = attrs[@"NSAttachment"];
        if (attach) {//如果是带有附件的富文本
            [string appendString:attach.emotion.chs];
        }else{//普通的文本
            //截取range
            NSString *substr = [self.attributedText attributedSubstringFromRange:range].string;
            [string appendString:substr];
        }
    }];
    return string;
}
@end
