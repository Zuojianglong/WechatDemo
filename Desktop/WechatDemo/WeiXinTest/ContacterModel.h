//
//  ContacterModel.h
//  WeiXinTest
//
//  Created by long on 16/5/21.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPJID.h"
//记录用户状态
typedef NS_ENUM(NSUInteger, UserStutas) {
    UserStutasOnline,//在线
    UserStutasOffline,//离线
    UserStutasLeave,//离开
};
@interface ContacterModel : NSObject
@property (nonatomic,strong)  XMPPJID *jid;
@property (nonatomic,  copy)  NSString *frendID;//好友的名字
@property (nonatomic,strong)  UIImage *headIcon;//好友头像
@property (nonatomic,  copy)  NSString *nickName;//用户的昵称
@property (nonatomic,  copy)  NSString *py; //用户名的拼音(全拼),用于处理分区头
@property (nonatomic,assign)  UserStutas userStatus;//用户状态
@property (nonatomic,strong)  Class vcClass;//跳转的控制器
@end
