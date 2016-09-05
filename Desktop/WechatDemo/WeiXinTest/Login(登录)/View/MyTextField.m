//
//  MyTextField.m
//  WeiXinTest
//
//  Created by long on 16/5/18.
//  Copyright © 2016年 long. All rights reserved.
//

#import "MyTextField.h"

@interface MyTextField ()
@property (nonatomic,strong) UIImageView *img;
@end
@implementation MyTextField
- (instancetype)init{
    self = [super init];
    
    if (self) {
        
        self.font = [UIFont systemFontOfSize:13];
        
    }
    return self;
}
- (void)setCustomPlaceholder:(NSString *)customPlaceholder{
    
    
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:customPlaceholder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    
    
}
- (void)setImage:(NSString *)image{
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:image]];
    imageView.frame = CGRectMake(0, 0, 30, 30);
    self.leftView = imageView;
    self.leftViewMode = UITextFieldViewModeAlways;
    self.img = imageView;
    
}
- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    
    return CGRectMake(0, 0, 40, 30);
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.img.frame = CGRectMake(0, 0, 30, 30);
}
@end
