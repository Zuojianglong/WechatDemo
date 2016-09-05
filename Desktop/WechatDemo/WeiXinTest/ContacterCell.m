//
//  ContacterCell.m
//  WeiXinTest
//
//  Created by long on 16/5/22.
//  Copyright © 2016年 long. All rights reserved.
//

#import "ContacterCell.h"
#import "ContacterView.h"
#import "ContacterModel.h"

@interface ContacterCell ()
@property (nonatomic,weak) ContacterView *cview;
@end

@implementation ContacterCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        //添加View
        [self setupSubview];
        
    }
    return self;
}
- (void)setupSubview{
    
    ContacterView *cView = [[ContacterView alloc]initWithFrame:self.bounds];
    [self.contentView addSubview:cView];
    self.cview = cView;
}
- (void)setContacterModel:(ContacterModel *)contacterModel{
    _contacterModel = contacterModel;
    
    self.cview.contacterModel = contacterModel;
}
@end
