//
//  ChatButtonView.m
//  WeiXinTest
//
//  Created by long on 16/5/24.
//  Copyright © 2016年 long. All rights reserved.
//

#import "ChatButtonView.h"
#import "SendTextView.h"

#define  centerMargin 5
#define  leftMargin   2
#define  buttonWidth  35
#define  buttonHeight buttonWidth
#define  inputViewH   36

@interface ChatButtonView ()
@property (nonatomic,weak) UIButton *temp;
@property (nonatomic,weak) UIButton *audioBtn;//语音按钮
@property (nonatomic,weak) UIButton *faceBtn;//表情按钮
@property (nonatomic,weak) UIButton *addImgBtn;//发送图片的按钮
@end
@implementation ChatButtonView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.width = ScreenWidth;
        self.height = BottomHeight;
        self.backgroundColor = [UIColor whiteColor];
        [self setupChildView];//添加子视图
        
    }
    
    return self;
}
- (void)setupChildView{
    //添加一条线
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    //添加语音按钮
    UIButton *audioBtn = [self addButtonWith:@"ToolViewInputVoice" highImage:@"ToolViewInputVoiceHL" tag:BottomButtonTypeAudio];
    self.audioBtn = audioBtn;
    //添加输入框
    [self addtextView];
    //添加表情按钮
    UIButton *faceBtn = [self addButtonWith:@"ToolViewEmotion" highImage:@"ToolViewEmotion" tag:BottomButtonTypeEmotion];
    self.faceBtn = faceBtn;
    //添加图片按钮
    UIButton *addImageBtn = [self addButtonWith:@"TypeSelectorBtn_Black" highImage:@"TypeSelectorBtnHL_Black" tag:BottomButtonTypeAddPicture];
    self.addImgBtn = addImageBtn;
    
}
#pragma mark 添加输入框
- (void)addtextView{
    SendTextView *send = [[SendTextView alloc]init];
    
    [self addSubview:send];
    self.bottomInputView = send;
    
}
#pragma mark 按钮模型
- (UIButton *)addButtonWith:(NSString *)image highImage:(NSString *)highImage tag:(BottomButtonType)type{
    
    UIButton *btn = [UIButton new];
    [btn setBackgroundImage:[UIImage resizedImage:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizedImage:highImage] forState:UIControlStateHighlighted];
    btn.tag = type;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    return btn;
}
- (void)buttonClick:(UIButton *)sender{
    
    //把按钮的事件传出去,传对象;
    if ([self.delegate respondsToSelector:@selector(chatBottomView:buttonTag:)]) {
        [self.delegate chatBottomView:self buttonTag:sender.tag];
    }
    
    
    
}
@end
