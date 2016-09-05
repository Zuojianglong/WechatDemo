//
//  LGEmotionToolbar.h
//  WeiXinTest
//
//  Created by long on 16/5/25.
//  Copyright © 2016年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LGEmotionToolbar;
typedef NS_ENUM(NSUInteger, LGEmotionType) {
    LGEmotionTypeRecent,//最近
    LGEmotionTypeDefault,//默认
    LGEmotionTypeEmoji,//emoji
    LGEmotionTypeLxh,//浪小花
    LGEmotionTypeSend,//发送按钮
};
@protocol LGEmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(LGEmotionToolbar *)toolbar didSelectedButton:(LGEmotionType)emotionType;
@end
@interface LGEmotionToolbar : UIView
@property (nonatomic, weak) id<LGEmotionToolbarDelegate> delegate;
@end
