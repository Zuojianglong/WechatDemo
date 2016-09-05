//
//  EditVCardViewcontroller.h
//  WeiXinTest
//
//  Created by long on 16/5/20.
//  Copyright © 2016年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditVCardViewcontroller;
@protocol EditVCardViewcontrollerDelegate <NSObject>
@optional
- (void)EditingFinished:(EditVCardViewcontroller *)edit  indexPath:(NSIndexPath*)indexPath newInfo:(NSString*)newInfo;

@end
@interface EditVCardViewcontroller : UITableViewController
@property (nonatomic,copy)   NSString *content;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,weak)   id<EditVCardViewcontrollerDelegate>delegate;
@end
