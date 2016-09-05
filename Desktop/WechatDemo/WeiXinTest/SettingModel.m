//
//  SettingModel.m
//  WeiXinTest
//
//  Created by long on 16/5/21.
//  Copyright © 2016年 long. All rights reserved.
//

#import "SettingModel.h"

@implementation SettingModel
+ (instancetype)settingWithTitle:(NSString *)title detailTitle:(NSString *)detailTitle{
    
    SettingModel *model = [SettingModel new];
    model.title = title;
    model.detailTitle = detailTitle;
    return model;
    
}
@end
