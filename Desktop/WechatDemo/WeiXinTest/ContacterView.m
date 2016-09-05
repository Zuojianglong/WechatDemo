//
//  ContacterView.m
//  WeiXinTest
//
//  Created by long on 16/5/22.
//  Copyright © 2016年 long. All rights reserved.
//

#import "ContacterView.h"
#import "ContacterModel.h"

#define marginLeft 10
#define headWidth  30
#define headHeight  headWidth
@interface ContacterView ()
@property (nonatomic,weak) UIImageView *head;
@property (nonatomic,weak) UILabel *name;
@end
@implementation ContacterView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubview];
    }
    return self;
}
- (void)setupSubview{
    //设置头像
    UIImageView *head = [UIImageView new];
    CGFloat headY = 7;
    head.frame = CGRectMake(marginLeft, headY, headWidth, headHeight);
    [self addSubview:head];
    self.head = head;
    //设置title
    UILabel *name = [UILabel new];
    name.font = MyFont(17);
    name.textColor = [UIColor blackColor];
    CGFloat nameX = head.right+marginLeft;
    name.frame = CGRectMake(nameX, 7, 250, headHeight);
    [self addSubview:name];
    self.name = name;
    
}
- (void)setContacterModel:(ContacterModel *)contacterModel{
    
    _contacterModel = contacterModel;
    self.head.image = contacterModel.headIcon? contacterModel.headIcon:[UIImage imageNamed:@"DefaultProfileHead_phone"];
    if (contacterModel.nickName) {
        self.name.text = contacterModel.nickName;
    }else{
        
        self.name.text = contacterModel.frendID;
    }
}
@end
