//
//  EditingCell.m
//  WeiXinTest
//
//  Created by long on 16/5/20.
//  Copyright © 2016年 long. All rights reserved.
//

#import "EditingCell.h"
#import "EditingView.h"

@interface EditingCell ()

@end
@implementation EditingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupTextField];
    }
    
    return self;
}
- (void)setupTextField{
    
    EditingView *edit = [[EditingView alloc]initWithFrame:self.bounds];
    edit.content = self.content;
    [self.contentView addSubview:edit];
    
    self.input = edit.textField;
   
    
}

@end
