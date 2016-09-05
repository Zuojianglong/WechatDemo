//
//  EditingView.m
//  WeiXinTest
//
//  Created by long on 16/5/20.
//  Copyright © 2016年 long. All rights reserved.
//

#import "EditingView.h"
#import "MyTextField.h"


@implementation EditingView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addEditInput];
    }
    return self;
    
}
- (void)addEditInput{
    
    MyTextField *input = [MyTextField new];
    input.left = 10;
    input.top = 0;
    input.width = ScreenWidth-20;
    input.height = self.height;
    input.font = MyFont(17);
    input.text = self.content;
    [self addSubview:input];
    self.textField = input;
    
}
- (void)setContent:(NSString *)content{
    self.textField.text = content;
    
}
@end
