//
//  MessageFrameModel.h
//  WeiXinTest
//
//  Created by long on 16/5/25.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MessageModel;
@interface MessageFrameModel : NSObject
@property (nonatomic,strong) MessageModel *messageModel;//传递模型
@property (nonatomic,assign,readonly) CGRect timeF;//时间的frame
@property (nonatomic,assign,readonly) CGRect headF;//头像的frame
//内容的frame
@property (nonatomic,assign,readonly) CGRect contentF;
//单元格的高度
@property (nonatomic,assign,readonly) CGFloat cellHeight;
//聊天单元的frame
@property (nonatomic,assign,readonly) CGRect  chatF;
@end
