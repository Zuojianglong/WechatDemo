//
//  Common.h
//  WeiXinTest
//
//  Created by long on 16/5/17.
//  Copyright © 2016年 long. All rights reserved.
//

#ifndef Common_h
#define Common_h
#define APP_ID @"WeiXinTest"
#define IOS7_OR_LATER [UIDevice currentDevice].systemVersion.floatValue>7.0
#define MyFont(s)  [UIFont systemFontOfSize:(s)]
#define LGColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LGColorAlpha(r,g,b,alp) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(alp)]
//屏幕的宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//屏幕的高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define MyDefaults [NSUserDefaults standardUserDefaults]
#define Mynotification [NSNotificationCenter defaultCenter]
//修改头像的通知
#define changeHeadNameNotif @"changeHeadIcon"
//发送消息的通知名
#define SendMsgName @"sendMessage"
//删除好友时发出的通知名
#define DeleteFriend @"deleteFriend"
//发送表情的按钮
#define FaceSendButton @"faceSendButton"

//---------------自己设置服务器信息 openfire
//服务器的ip地址
#define ServerAddress @"60.172.229.162"
//服务器的端口号
#define ServerPort 5222
//服务器的域名
#define ServerName @"ios268"


/** 表情相关 */
// 表情的最大行数
#define LGEmotionMaxRows 3
// 表情的最大列数
#define LGEmotionMaxCols 7
// 每页最多显示多少个表情
#define LGEmotionMaxCountPerPage (LGEmotionMaxRows * LGEmotionMaxCols - 1)

// 通知
// 表情选中的通知
#define LGEmotionDidSelectedNotification @"LGEmotionDidSelectedNotification"
// 点击删除按钮的通知
#define LGEmotionDidDeletedNotification @"LGEmotionDidDeletedNotification"
// 通知里面取出表情用的key
#define LGSelectedEmotion @"LGSelectedEmotion"


#endif /* Common_h */
