//
//  VCardModel.h
//  WeiXinTest
//
//  Created by long on 16/5/20.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UserInfoType) {
    UserNickName,
    UserWeixinNum,
    UserCompany,
    UserDepartment,
    UserWorker,
    UserTel,
    UserEmail,
};

@interface VCardModel : NSObject
//存放信息的文本
@property (nonatomic,copy)   NSString*info;
//列表的名字
@property (nonatomic,copy)   NSString *name;
//存放图片(data)
@property (nonatomic,strong) NSData *image;
//枚举--信息类型
@property (nonatomic,assign) UserInfoType infoType;

//初始化方法,保存信息
+ (instancetype)VCardWithInfo:(NSString *)info infoType:(UserInfoType)infoType name:(NSString *)name;
+(instancetype)VCardWithImage:(NSData *)image name:(NSString *)name;
@end
