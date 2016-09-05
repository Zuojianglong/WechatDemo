//
//  ChatViewShow.m
//  WeiXinTest
//
//  Created by long on 16/5/25.
//  Copyright © 2016年 long. All rights reserved.
//

#import "ChatViewShow.h"
#import "MessageFrameModel.h"
#import "MessageModel.h"
@interface ChatViewShow ()
@property (nonatomic,weak) UILabel *timeLabel;
//正文内容
@property (nonatomic,weak) UIButton *contentBtn;
//头像
@property (nonatomic,weak) UIImageView *headImage;
//
@end
@implementation ChatViewShow
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self setupChildView];
        
    }
    return self;
}
- (void)setupChildView{
    //时间
    UILabel *timeLab = [UILabel new];
    timeLab.textColor = [UIColor lightGrayColor];
    timeLab.font = MyFont(15);
    timeLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:timeLab];
    self.timeLabel = timeLab;
    //正文
    UIButton *contentButton = [UIButton new];
    contentButton.titleLabel.font = MyFont(15);
    contentButton.titleLabel.numberOfLines = 0;
    contentButton.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 20, 20);
    [self addSubview:contentButton];
    self.contentBtn = contentButton;
    //头像
    UIImageView *headImage = [UIImageView new];
    [self addSubview:headImage];
    self.headImage = headImage;
    
}
- (void)setFrameModel:(MessageFrameModel *)frameModel{
    
    _frameModel = frameModel;
    
    self.frame = frameModel.chatF;
    //时间的frame
    self.timeLabel.frame = frameModel.timeF;
    self.timeLabel.text = frameModel.messageModel.time;
    //头像
    if (frameModel.messageModel.isCurrentUser) {
        //是自己
        UIImage *head = frameModel.messageModel.headImage? [UIImage imageWithData:frameModel.messageModel.headImage]:[UIImage imageNamed:@"DefaultCompanyHead"];
        self.headImage.image = head;
        
    }else{
        self.headImage.image=frameModel.messageModel.otherPhoto?frameModel.messageModel.otherPhoto:[UIImage imageNamed:@"DefaultHead"];
    }
    
    self.headImage.frame = frameModel.headF;
    //内容的frame
    [self.contentBtn setAttributedTitle:frameModel.messageModel.attributedBody forState:UIControlStateNormal];
    self.contentBtn.frame = frameModel.contentF;
    //设置聊天的背景图片
    if (frameModel.messageModel.isCurrentUser) {
        //自己
        [self.contentBtn setBackgroundImage:[UIImage resizedImage:@"SenderTextNodeBkg"] forState:UIControlStateNormal];
        
    }else{//别人
        [self.contentBtn setBackgroundImage:[UIImage resizedImage:@"ReceiverAppNodeBkg"] forState:UIControlStateNormal];
    }
    
}
@end
