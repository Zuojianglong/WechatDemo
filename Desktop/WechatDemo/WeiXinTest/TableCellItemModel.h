//
//  TableCellItemModel.h
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Myblock)();
@interface TableCellItemModel : NSObject
@property (nonatomic,copy) NSString *icon;//图标
@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic,copy) NSString *detailTitle;//子标题
@property (nonatomic,copy) NSData *image;//图片的二进制数据
@property (nonatomic,copy) Myblock option;//操作
@property (nonatomic,strong) Class vcClass;//进入的vc
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title detailTitle:(NSString *)detailTitle vcClass:(Class)vcClass;
@end
