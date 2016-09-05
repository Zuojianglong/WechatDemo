//
//  LGEmotionToolbar.m
//  WeiXinTest
//
//  Created by long on 16/5/25.
//  Copyright © 2016年 long. All rights reserved.
//

#import "LGEmotionToolbar.h"


#define LGEmotionToolbarButtonMaxCount 5
@interface LGEmotionToolbar()

// 记录当前选中的按钮
@property (nonatomic, weak) UIButton *selectedButton;
@end
@implementation LGEmotionToolbar
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        // 1.添加4个按钮
        [self setupButton:nil image:@"Expression_67" tag:LGEmotionTypeRecent];
        [self setupButton:nil image:@"Expression_1" tag:LGEmotionTypeDefault];
        [self setupButton:nil image:@"EmotionsEmojiHL" tag:LGEmotionTypeEmoji];
        [self setupButton:nil image:@"lxh_buhaoyisi" tag:LGEmotionTypeLxh];
        //2.添加发送按钮
        [self addSendButton:@"发送" tag:LGEmotionTypeSend];
        // 3.监听表情选中的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:LGEmotionDidSelectedNotification object:nil];
    }
    
    return self;
}
#pragma mark 添加发送按钮
-(UIButton*)addSendButton:(NSString*)title tag:(LGEmotionType)tag
{
    UIButton *send=[[UIButton alloc]init];
    send.tag=tag;
    [send setTitle:title forState:UIControlStateNormal];
    [send setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [send setBackgroundColor:[UIColor blueColor]];
    send.titleLabel.font=MyFont(14);
    [send addTarget:self action:@selector(sendButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:send];
    return send;
}
/**
  *  添加按钮
  *
  *  @param title 按钮文字
  */
- (UIButton *)setupButton:(NSString *)title image:(NSString*)image tag:(LGEmotionType)tag{
    
    UIButton *button = [UIButton new];
    button.tag = tag;
    if (image) {
        //如果有图片 就没有文字
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }else{
        //文字
        [button setTitle:title forState:UIControlStateNormal];
        
    }
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    //添加按钮
    [self addSubview:button];
    
    NSInteger count = self.subviews.count;
    if (count == 1) {
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    }else if (count == LGEmotionToolbarButtonMaxCount){//最后一个按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    }else{ // 中间按钮
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    return button;
}
#pragma mark 通知的事件
- (void)emotionDidSelected:(NSNotification *)note{
    if (self.selectedButton.tag ==LGEmotionTypeRecent) {
        [self buttonClick:self.selectedButton];
    }
    
}
/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button{
    //控制按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    //代理
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:button.tag];
    }
    
}
#pragma mark 发送按钮的点击方法
-(void)sendButtonClick:(UIButton*)sender{
    //发送通知
    NSNotification *note = [[NSNotification alloc]initWithName:FaceSendButton object:nil userInfo:nil];
    [Mynotification postNotification:note];
    
}
#pragma mark  代理的set方法
- (void)setDelegate:(id<LGEmotionToolbarDelegate>)delegate{
    _delegate = delegate;
    UIButton *defaultButton = (UIButton *)[self viewWithTag:LGEmotionTypeDefault];
    [self buttonClick:defaultButton];//默认选中 默认按钮
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //设置工具条按钮的frame
    
    CGFloat buttonW = self.width / LGEmotionToolbarButtonMaxCount;
    CGFloat buttonH = self.height;
    for (int i = 0; i < LGEmotionToolbarButtonMaxCount; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = buttonW;
        btn.height = buttonH;
        btn.left = i*buttonW;
        
    }
    
    
}
@end
