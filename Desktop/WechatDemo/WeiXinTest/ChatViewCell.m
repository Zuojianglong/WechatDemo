//
//  ChatViewCell.m
//  WeiXinTest
//
//  Created by long on 16/5/25.
//  Copyright © 2016年 long. All rights reserved.
//

#import "ChatViewCell.h"
#import "MessageFrameModel.h"
#import "ChatViewShow.h"

@interface ChatViewCell ()
@property (nonatomic,weak) ChatViewShow *show;
@end
@implementation ChatViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self setupChildView];
    }
    
    return self;
}
- (void)setupChildView{
    
    ChatViewShow *show = [ChatViewShow new];
    [self.contentView addSubview:show];
    self.show = show;
 
}
- (void)setFrameModel:(MessageFrameModel *)frameModel{
    
    self.show.frameModel = frameModel;
    
}
@end
