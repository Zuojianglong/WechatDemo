//
//  SettingViewCell.h
//  WeiXinTest
//
//  Created by long on 16/5/21.
//  Copyright © 2016年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingModel;
@interface SettingViewCell : UITableViewCell
@property (nonatomic,strong) SettingModel *settingModel;

+(instancetype)cellWithTableView:(UITableView*)table indexPath:(NSIndexPath *)indexPath indentifier:(NSString*)indentifier;//可用可不用(现在这个方法没有实现)
@end
