//
//  XMPPTools.m
//  WeiXinTest
//
//  Created by long on 16/5/17.
//  Copyright © 2016年 long. All rights reserved.
//

#import "XMPPTools.h"
#import "UserOperation.h"

@interface XMPPTools ()<XMPPStreamDelegate>
{
    //定义这个block
    XMPPResultBlock _resultBlock;
    //自动连接对象
    XMPPReconnect *_reconnect;
    //定义一个消息对象
    XMPPMessageArchiving *_messageArching;
    //电子名片存储
    XMPPvCardCoreDataStorage *_vCardStorage;
    
    
}

@end

@implementation XMPPTools
SingletonM(xmpp);
- (void)setupXmppStream{
    
    _xmppStream = [[XMPPStream alloc]init];
#warning 每个模块的添加都需要去激活
    //1.添加自动连接模块
    _reconnect = [XMPPReconnect new];
    //2.添加电子名片模块
    _vCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    _vCard = [[XMPPvCardTempModule alloc]initWithvCardStorage:_vCardStorage];
    [_vCard activate:_xmppStream];//激活
    //3.添加头像模块
    _avatar = [[XMPPvCardAvatarModule alloc]initWithvCardTempModule:_vCard];
    [_avatar activate:_xmppStream];
    //4.添加花名册
    _rosterStorage = [XMPPRosterCoreDataStorage new];
    _roster = [[XMPPRoster alloc]initWithRosterStorage:_rosterStorage];
    [_roster activate:_xmppStream];
    //5.添加聊天模块
    _messageStroage = [XMPPMessageArchivingCoreDataStorage new];
    _messageArching = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:_messageStroage];
    [_messageArching activate:_xmppStream];
    
    
    //添加代理 把xmpp流放到子线程
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
}
#pragma mark 连接到服务器
- (void)connectToHost{
    
    if (!_xmppStream) {
        
        [self setupXmppStream];
        
    }
    //设置用户的ID
    UserOperation *user = [UserOperation shareduser];
    NSString *userName = user.uname;
    XMPPJID *myJid = [XMPPJID jidWithUser:userName domain:ServerName resource:nil];
    self.jid = myJid;
    //设置服务器域名或者IP地址
    _xmppStream.hostName = ServerAddress;//IP地址或域名
    _xmppStream.hostPort = ServerPort;
    
    //连接到服务器
    NSError *error = nil;
    if (![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error]) {
        
        NSLog(@"XMPP connect error-->%@",error);
        
    }
    
    
}
#warning 以下为xmpp的代理方法
#pragma mark 连接成功调用这个方法
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    
    NSLog(@"连接主机成功");
    if (self.isRegisterOperation) {//注册操作
        
        UserOperation *user = [UserOperation shareduser];
        NSString *password = user.password;
        [_xmppStream registerWithPassword:password error:nil];
        
    }else{//登录操作
        
        [self sendPwdToHost];
        
    }
    
    
    
}
#pragma mark 连接到服务器以后 在发送密码.(先发送账号,建立连接;在发送密码进行注册登录)
- (void)sendPwdToHost{
    
    UserOperation *user = [UserOperation shareduser];
    NSString *password = user.password;
    //验证密码
    NSError *error = nil;
    [_xmppStream authenticateWithPassword:password error:&error];
    if (error) {
        
        NSLog(@"XMPP 授权错误-->%@",error);
    }
    
    
}
#pragma mark 连接失败的方法
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{

    if (error && _resultBlock) {
        _resultBlock(XMPPResultNetworkErr);//网络出现的问题
    }
    
    NSLog(@"连接断开");
    
}
#pragma mark 验证密码成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    //发送在线消息
    [self sendOnlineMessage];
    if (_resultBlock) {
        _resultBlock(XMPPResultSuccess);
    }
    
}
- (void)sendOnlineMessage{
    XMPPPresence *presence = [XMPPPresence presence];
    NSLog(@"%@",presence);
    //把在线情况发送给服务器
    [_xmppStream sendElement:presence];
    
}

#pragma mark 验证密码错误
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    
    NSLog(@"密码验证失败");
    if (_resultBlock) {
        _resultBlock(XMPPResultFaiture);
    }
    
}
#pragma mark 注册成功的方法
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    
    NSLog(@"注册成功");
    if (_resultBlock) {
        _resultBlock(XMPPResultRegisterSuccess);
    }
    
    
}
#pragma mark 注册失败的方法
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    
    NSLog(@"注册失败 %@",error);
    if (_resultBlock) {
        _resultBlock(XMPPResultRegisterFailture);
    }
    
}

#pragma mark 收到消息的事件
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    
    //NSLog(@"有新的消息! %@",message);
    
    NSDate *date = [self getDelayStampTime:message];
    if (!date) {
        date = [NSDate date];
    }
    
    NSDateFormatter *formatter =[NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [formatter stringFromDate:date];
    //1.NSLog(@"离线消息:(%@)",strDate);
    
    XMPPJID *jid = [message from];
   //jid.user 通过这个可以获得用户名
    
    //获取body里面的内容
    NSString *body = [[message elementForName:@"body"] stringValue];;
    //2.本地推送
    UILocalNotification *local = [UILocalNotification new];
    local.alertBody = body;
    local.alertAction = body;
    local.soundName = [[NSBundle mainBundle]pathForResource:@"shake_match" ofType:@"mp3"];
    local.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication]scheduleLocalNotification:local];
    
    //3.发送个通知
    if (body) {
        NSDictionary *dict = @{@"uname":jid.user,@"time":strDate,@"body":body,@"jid":jid,@"user":@"other"};
        NSNotification *note = [[NSNotification alloc]initWithName:SendMsgName object:dict userInfo:nil];
        [Mynotification postNotification:note];
    }
    
    
}
- (NSDate *)getDelayStampTime:(XMPPMessage *)message{
   //获得xml中的delay元素
    XMPPElement *delay = (XMPPElement *)[message elementsForName:@"delay"];
    if (delay) {
        //如果这个值存在,表示是个离线消息
        //获得时间戳
        
        NSString *timeString = [[delay attributeForName:@"stamp"]stringValue];
        //事件格式器
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        //按照T 把字符串分隔成数组
        NSArray *arr = [timeString componentsSeparatedByString:@"T"];
        //获得日期字符串
        NSString *dateStr = arr[0];
        NSString *timeStr = [arr[1] componentsSeparatedByString:@"."][0];
        //构建一个日期对象 这个对象的时区为0
        
        NSDate *localDate = [formatter dateFromString:[NSString stringWithFormat:@"%@T%@+0000",dateStr,timeStr]];
        return localDate;
        
    }else{
        return nil;
    }
    
}
#pragma mark 发送消息得到方法

-(void)sendMessage:(NSString *)_msg to:(NSString *)_toName{
    
   //创建一个xml
    //创建元素
    NSXMLElement *message = [[NSXMLElement alloc]initWithName:@"message"];
    
    //定制根元素的属性
    [message addAttributeWithName:@"type" stringValue:@"chat"];
#warning LocalHostOperation.......
    [message addAttributeWithName:@"from" stringValue:@"jack@localhost"];
    [message addAttributeWithName:@"to" stringValue:[NSString stringWithFormat:@"%@@%@",_toName,ServerName]];
    //穿件一个子元素
    NSXMLElement *body = [[NSXMLElement alloc]initWithName:@"body"];
    [body setStringValue:_msg];
    [message addChild:body];
    
    //发送消息
    [_xmppStream sendElement:message];
    
    
    
}


#pragma mark 登陆的方法
- (void)login:(XMPPResultBlock)xmppBlock{
    
    _resultBlock = xmppBlock;
    [_xmppStream disconnect];//断开服务器重新连接
    [self connectToHost];//连接到服务器
    
}
#pragma mark 注册的方法
- (void)regist:(XMPPResultBlock)xmppType{
    
    _resultBlock = xmppType;
    //断开连接
    [_xmppStream disconnect];
    //连接主机
    [self connectToHost];
    
    
}
#pragma mark 退出登录的操作
- (void)xmppLoginOut{
    [self goOffline];
    [_xmppStream disconnect];
    UserOperation *user = [UserOperation shareduser];
    user.uname = nil;
    user.password = nil;
    user.loginStatus = NO;//退出登录状态
    
    
}
- (void)goOffline{
    //发送离线消息给服务器
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:presence];
}


#pragma mark  当对象销毁的时候

- (void)dealloc{
    
    [self teardownXmpp];
}

-(void)teardownXmpp{
   //1.移除代理
    [_xmppStream removeDelegate:self];
    //2.停止模块
    [_reconnect deactivate];
    [_vCard deactivate];
    [self.vCard deactivate];
    [_avatar deactivate];
    [_reconnect deactivate];
    [_roster deactivate];
    //3.断开网络
    [_xmppStream disconnect];
    //4.清理对象
    _reconnect=nil;
    _vCard=nil;
    _vCardStorage=nil;
    _avatar=nil;
    _rosterStorage=nil;
    _roster=nil;
    _xmppStream=nil;
    
}


@end
