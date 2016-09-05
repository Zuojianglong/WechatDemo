//
//  UserOperation.h
//  WeiXinTest
//
//  Created by long on 16/5/17.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserOperation : NSObject
SingletonH(user);
@property (nonatomic,copy)   NSString *uname;
@property (nonatomic,copy)   NSString *password;
@property (nonatomic,assign) BOOL loginStatus;
+ (void)loginByStatus;
@end
