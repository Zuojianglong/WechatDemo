//
//  LGEmotionTool.m
//  WeiXinTest
//
//  Created by long on 16/5/25.
//  Copyright © 2016年 long. All rights reserved.
//

#import "LGEmotionTool.h"
#import "LGEmotion.h"

#define LGRecentFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent_emotions.data"]

@implementation LGEmotionTool
/** 默认表情 */
static NSArray *_defaultEmotions;
/** emoji表情 */
static NSArray *_emojiEmotions;
/** 浪小花表情 */
static NSArray *_lxhEmotions;

/** 最近表情 */
static NSMutableArray *_recentEmotions;
+ (NSArray *)defaultEmotions{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [LGEmotion objectArrayWithFile:plist];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
    
}
+ (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [LGEmotion objectArrayWithFile:plist];
        [_emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
    }
    return _emojiEmotions;
}
+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [LGEmotion objectArrayWithFile:plist];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}
+ (NSArray *)recentEmotions{
    if (!_recentEmotions) {
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:LGRecentFilepath];
        if (!_recentEmotions) {
            _recentEmotions = [NSMutableArray array];
        }
        
        
    }
    
    return _recentEmotions;
}

//emotion---
+ (void)addRecentEmotion:(LGEmotion *)emotion{
    
    [self recentEmotions];//加载最近添加的表情数据
    [_recentEmotions removeObject:emotion];
    [_recentEmotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:LGRecentFilepath];//重新写入本地
    
    
}

+ (LGEmotion *)emotionWithDesc:(NSString *)desc{
    if (!desc) return nil;
    __block LGEmotion *foundEmotion = nil;
    
    //先从默认表情中找
    [[self defaultEmotions]enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LGEmotion *emotion = obj;
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;//用来暂停查找
        }
    }];
    if(foundEmotion) return foundEmotion;
    
    //从浪小花表情中查找
    [[self lxhEmotions]enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LGEmotion *emotion = obj;
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;//用来暂停查找
        }
    }];
    
    return foundEmotion;
    
}
@end
