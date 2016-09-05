//
//  SettingModel.h
//  WeiXinTest
//
//  Created by long on 16/5/21.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *detailTitle;
@property (nonatomic,assign) BOOL isLoginOut;
+ (instancetype)settingWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle;
@end
