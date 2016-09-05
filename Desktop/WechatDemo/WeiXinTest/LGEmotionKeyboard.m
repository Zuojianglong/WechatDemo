//
//  LGEmotionKeyboard.m
//  WeiXinTest
//
//  Created by long on 16/5/25.
//  Copyright © 2016年 long. All rights reserved.
//

#import "LGEmotionKeyboard.h"
#import "LGEmotionTool.h"
#import "LGEmotionListView.h"
#import "LGEmotionToolbar.h"

@interface LGEmotionKeyboard ()<LGEmotionToolbarDelegate>
/** 表情列表 */
@property (nonatomic, weak) LGEmotionListView *listView;
/** 表情工具条 */
@property (nonatomic, weak) LGEmotionToolbar *toolbar;
@end
@implementation LGEmotionKeyboard
+ (instancetype)keyboard{
    
    return [[self alloc]init];
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame: frame];
    if (self) {
        //
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage resizedImage:@"emoticon_keyboard_background"]];
        //添加表情列表
        LGEmotionListView *listView = [LGEmotionListView new];
        [self addSubview:listView];
        self.listView = listView;
        //添加表情工具条
        LGEmotionToolbar *toolBar = [LGEmotionToolbar new];
        toolBar.delegate =self;
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置工具条的frame
    self.toolbar.width = self.width;
    self.toolbar.height = 35;
    self.toolbar.top = self.height - self.toolbar.height;
    
    // 2.设置表情列表的frame
    self.listView.width = self.width;
    self.listView.height = self.toolbar.top;
}

#pragma mark - HMEmotionToolbarDelegate
- (void)emotionToolbar:(LGEmotionToolbar *)toolbar didSelectedButton:(LGEmotionType)emotionType
{
    switch (emotionType) {
        case LGEmotionTypeDefault:// 默认
            self.listView.emotions = [LGEmotionTool defaultEmotions];
            break;
            
        case LGEmotionTypeEmoji: // Emoji
            self.listView.emotions = [LGEmotionTool emojiEmotions];
            break;
            
        case LGEmotionTypeLxh: // 浪小花
            self.listView.emotions = [LGEmotionTool lxhEmotions];
            break;
            
        case LGEmotionTypeRecent: // 最近
            self.listView.emotions = [LGEmotionTool recentEmotions];
            break;
    }
}
@end
