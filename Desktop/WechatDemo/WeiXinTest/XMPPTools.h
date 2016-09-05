//
//  XMPPTools.h
//  WeiXinTest
//
//  Created by long on 16/5/17.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"

typedef NS_ENUM(NSUInteger, XMPPResultType) {
    XMPPResultSuccess,//登陆成功
    XMPPResultFaiture,//登录失败
    XMPPResultNetworkErr,//网络出错
    XMPPResultRegisterSuccess,//注册成功
    XMPPResultRegisterFailture,//注册失败
};
typedef void(^XMPPResultBlock)(XMPPResultType xmppType);

@interface XMPPTools : NSObject
SingletonH(xmpp); //实现单例
@property (nonatomic,strong) XMPPStream *xmppStream;//xmppstream  流
@property (nonatomic,strong) XMPPJID *jid;//定义一个xmppJid
@property (nonatomic,assign,getter=isRegisterOperation) BOOL registerOperation;//如果是YES就是注册的方法
@property (nonatomic,strong,readonly) XMPPRoster *roster;//添加花名册模块(添加好友)
@property (nonatomic,strong,readonly) XMPPRosterCoreDataStorage *rosterStorage;
//聊天模块
@property (nonatomic,strong,readonly) XMPPMessageArchivingCoreDataStorage *messageStroage;
//电子名片
@property (nonatomic,strong,readonly) XMPPvCardTempModule *vCard;
//头像模块
@property (nonatomic,strong,readonly) XMPPvCardAvatarModule  *avatar;

//登陆的方法
-(void)login:(XMPPResultBlock)xmppBlock;
//退出的方法
-(void)xmppLoginOut;  //退出登录的操作
//注册的方法
-(void)regist:(XMPPResultBlock)xmppType;

-(void)sendMessage:(NSString *)_msg to:(NSString *)_toName;//发送消息
@end
