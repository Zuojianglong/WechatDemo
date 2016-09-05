//
//  MessageModel.h
//  WeiXinTest
//
//  Created by long on 16/5/25.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic,copy) NSString *body; //消息的内容
@property (nonatomic,copy) NSAttributedString *attributedBody;

@property (nonatomic,copy) NSString *time; //消息的时间
@property (nonatomic,assign) BOOL isCurrentUser;//yes 为当前用户,no为不是
@property (nonatomic,copy) NSString *from;//谁发的消息
@property (nonatomic,copy) NSString *to;//发给谁消息
@property (nonatomic,weak) UIImage *otherPhoto;
@property (nonatomic,strong) NSData *headImage;
@property (nonatomic,assign) BOOL HiddenTime;//是否隐藏时间
@end
