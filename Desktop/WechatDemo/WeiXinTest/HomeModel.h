//
//  HomeModel.h
//  WeiXinTest
//
//  Created by long on 16/5/23.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject
@property (nonatomic,copy) NSData *headerIcon;//头像
@property (nonatomic,copy) NSString *uname;//标题
//子标题
@property (nonatomic,copy) NSString *body;//子标题
//时间
@property (nonatomic,copy) NSString  *time;//时间(yyyy-MM-ss HH-mm-ss);
//jid
@property (nonatomic,strong) XMPPJID *jid; //聊天用户的jid
//数字提醒按钮
@property (nonatomic,copy) NSString *badgeValue;
@end
