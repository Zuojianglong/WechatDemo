//
//  EditingCell.h
//  WeiXinTest
//
//  Created by long on 16/5/20.
//  Copyright © 2016年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTextField;
@interface EditingCell : UITableViewCell
@property (nonatomic,weak) MyTextField *input;
@property (nonatomic,copy) NSString *content;
@end
