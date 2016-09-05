//
//  AddfriendCell.m
//  WeiXinTest
//
//  Created by long on 16/5/22.
//  Copyright © 2016年 long. All rights reserved.
//

#import "AddfriendCell.h"
#import "AddFriendView.h"
#import "MyTextField.h"


@implementation AddfriendCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        [self setupSubview];
        
    }
    return self;
}
- (void)setupSubview{
    
    AddFriendView *aView = [[AddFriendView alloc]initWithFrame:self.bounds];
    [self.contentView addSubview:aView];
    self.textField = aView.textField;
    
}
@end
