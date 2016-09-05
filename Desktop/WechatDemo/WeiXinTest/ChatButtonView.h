//
//  ChatButtonView.h
//  WeiXinTest
//
//  Created by long on 16/5/24.
//  Copyright © 2016年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SendTextView;
@class ChatButtonView;
//定义此view的高度
#define BottomHeight 49

typedef NS_ENUM(NSUInteger, BottomButtonType) {
    BottomButtonTypeEmotion,    //表情按钮
    BottomButtonTypeAddPicture, //图片按钮
    BottomButtonTypeAudio,      //语音按钮
};
@protocol ChatButtonViewDelegate <NSObject>

@optional
- (void)chatBottomView:(ChatButtonView *)bottomView buttonTag:(BottomButtonType)buttonTag;
@end

@interface ChatButtonView : UIView
@property (nonatomic,weak) SendTextView *bottomInputView;
@property (nonatomic,weak) id<ChatButtonViewDelegate>delegate;
@property (nonatomic,assign) BOOL emotionStatus;//表情按钮的选中状态
@property (nonatomic,assign) BOOL addStatus;//添加图片按钮的选中状态
@end
