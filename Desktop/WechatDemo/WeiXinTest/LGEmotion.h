//
//  LGEmotion.h
//  WeiXinTest
//
//  Created by long on 16/5/24.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LGEmotion : NSObject<NSCoding>
//描述表情的文字描述
@property (nonatomic,copy) NSString *chs;
@property (nonatomic,copy) NSString *cht;
//表情的png的图片名
@property (nonatomic,copy) NSString *png;
//emoji表情的编码
@property (nonatomic,copy) NSString *code;

//表情的存放文件夹/目录
@property (nonatomic,copy) NSString *directory;
//emoji 表情的字符
@property (nonatomic,copy) NSString *emoji;

@end
