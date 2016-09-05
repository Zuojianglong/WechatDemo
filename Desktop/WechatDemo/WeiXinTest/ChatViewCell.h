//
//  ChatViewCell.h
//  WeiXinTest
//
//  Created by long on 16/5/25.
//  Copyright © 2016年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageFrameModel;
@interface ChatViewCell : UITableViewCell
@property (nonatomic,strong) MessageFrameModel *frameModel;
@end
