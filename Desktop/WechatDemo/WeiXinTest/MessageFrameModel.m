//
//  MessageFrameModel.m
//  WeiXinTest
//
//  Created by long on 16/5/25.
//  Copyright © 2016年 long. All rights reserved.
//

#import "MessageFrameModel.h"
#import "MessageModel.h"

#define headIconW 40
#define contentFont MyFont(15)
//聊天内容的文字距离四边的距离
#define ContentEdgeInsets 20
@implementation MessageFrameModel
- (void)setMessageModel:(MessageModel *)messageModel{
    _messageModel = messageModel;
    CGFloat pading = 10; //间距
    if (messageModel.HiddenTime == NO) {
        
        _timeF = CGRectMake(0, 0, ScreenWidth, 30);
    }
    //设置头像
    CGFloat iconW = headIconW;
    CGFloat iconH = headIconW;
    CGFloat iconX = 0;
    CGFloat iconY = CGRectGetMaxY(_timeF)+pading;
    if (messageModel.isCurrentUser) {
        iconX = ScreenWidth-iconW-pading;
    }else{
        iconX = pading;
    }
    _headF = CGRectMake(iconX, iconY, iconW, iconH);
    //设置聊天内容frame 宽度最大为200;
    CGSize contentSize = CGSizeMake(200, CGFLOAT_MAX);
    CGRect contentR;
    //如果有表情
    
    contentR = [messageModel.attributedBody boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGFloat contentW = contentR.size.width+ContentEdgeInsets*2;
    CGFloat contentH=contentR.size.height+ContentEdgeInsets*2;
    CGFloat contentY=iconY-2;
    CGFloat contentX=0;
    if (messageModel.isCurrentUser) {
        contentX = iconX-pading-contentW;
    }else{
        
        contentX = CGRectGetMaxX(_headF)+pading;
    }
    _contentF = CGRectMake(contentX, contentY, contentW, contentH);
    
    CGFloat maxIconY = CGRectGetMaxY(_headF);
    CGFloat maxContentY = CGRectGetMaxY(_contentF);
    //cell的高度
    _cellHeight = MAX(maxIconY, maxContentY)+pading;
    //聊天单元格的frame
    _chatF = CGRectMake(0, 0, ScreenWidth, _cellHeight);
    
}
@end
