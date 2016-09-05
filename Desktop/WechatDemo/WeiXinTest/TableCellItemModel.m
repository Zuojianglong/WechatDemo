//
//  TableCellItemModel.m
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import "TableCellItemModel.h"

@implementation TableCellItemModel
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title detailTitle:(NSString *)detailTitle vcClass:(Class)vcClass{
    
    TableCellItemModel *model = [[self class] new];
    model.title = title;
    model.detailTitle = detailTitle;
    model.icon = icon;
    model.vcClass = vcClass;
    
    return model;
}
@end
