//
//  TableGroupModel.h
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableGroupModel : NSObject
@property (nonatomic,copy) NSString *header;
@property (nonatomic,copy) NSString *footer;
@property (nonatomic,strong) NSArray *items;//存放储存的tablecellItem的模型
@end
