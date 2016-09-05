//
//  ChatViewcontroller.h
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMPPJID;
@interface ChatViewcontroller : UIViewController
@property (nonatomic,strong) XMPPJID *jid;
@property (nonatomic,strong) UIImage *photo;//聊天对象
@end
