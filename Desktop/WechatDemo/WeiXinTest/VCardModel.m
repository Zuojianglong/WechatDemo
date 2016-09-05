//
//  VCardModel.m
//  WeiXinTest
//
//  Created by long on 16/5/20.
//  Copyright © 2016年 long. All rights reserved.
//

#import "VCardModel.h"

@implementation VCardModel
+ (instancetype)VCardWithInfo:(NSString *)info infoType:(UserInfoType)infoType name:(NSString *)name{
    
    VCardModel *vCard = [VCardModel new];
    vCard.info = info;
    vCard.infoType = infoType;
    vCard.name = name;
    
    return vCard;
}
+(instancetype)VCardWithImage:(NSData *)image name:(NSString *)name
{
    VCardModel *vCard = [VCardModel new];
    vCard.image = image;
    vCard.name = name;
    return vCard;
}
@end
