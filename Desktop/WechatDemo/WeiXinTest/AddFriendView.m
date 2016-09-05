//
//  AddFriendView.m
//  WeiXinTest
//
//  Created by long on 16/5/22.
//  Copyright © 2016年 long. All rights reserved.
//

#import "AddFriendView.h"
#import "MyTextField.h"

#define marginLeft 20
@implementation AddFriendView
- (instancetype)initWithFrame:(CGRect)frame{
    
   self =  [super initWithFrame:frame];
    if (self) {
     
        [self addChildView];
    }
    return self;
}
- (void)addChildView{
    
    MyTextField *myTF = [MyTextField new];
    myTF.font = MyFont(16);
    myTF.returnKeyType = UIReturnKeyDone;
    myTF.enablesReturnKeyAutomatically = YES;
    myTF.image = @"add_friend_icon_search";
    myTF.placeholder = @"微信号/手机号";
    
    myTF.height = 30;
    myTF.left = marginLeft;
    myTF.width = ScreenWidth-marginLeft*2;
    myTF.top = (self.height-myTF.height)*0.5;
    
    [self addSubview:myTF];
    self.textField = myTF;
    
    
    
    
}
@end
