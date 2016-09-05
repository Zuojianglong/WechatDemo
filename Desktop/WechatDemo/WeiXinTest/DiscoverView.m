//
//  DiscoverView.m
//  WeiXinTest
//
//  Created by long on 16/5/19.
//  Copyright © 2016年 long. All rights reserved.
//

#import "DiscoverView.h"
#import "TableCellItemModel.h"

#define headWidth 30
#define headHeigt headWidth
#define marginLeft 10

@interface DiscoverView ()
@property (nonatomic,weak) UIImageView *header;
@property (nonatomic,weak) UILabel     *text;
@property (nonatomic,weak) UILabel     *detailText;
@property (nonatomic,weak) UIButton    *arrow;
@end

@implementation DiscoverView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    //添加视图
        [self addDiscoverView];
        
    }
    
    return self;
}
- (void)addDiscoverView{
   //添加头像
    
    UIImageView *header = [UIImageView new];
    CGFloat headerY = 7;
    header.frame = CGRectMake(marginLeft, headerY, headWidth, headHeigt);
    [self addSubview:header];
    self.header = header;
    //添加标题
    UILabel *text = [UILabel new];
    text.font = MyFont(17);
    CGFloat textX = header.right+marginLeft*2;
    text.textColor = [UIColor blackColor];
    text.textAlignment = NSTextAlignmentLeft;
    text.frame = CGRectMake(textX, 7, 200, headHeigt);
    [self addSubview:text];
    self.text = text;
    //添加子标题
    UILabel *detailText = [UILabel new];
    detailText.font = MyFont(15);
    detailText.textColor = [UIColor lightGrayColor];
    detailText.hidden = YES;
    [self addSubview: detailText];
    self.detailText = detailText;
    //添加箭头
    UIButton *arrow = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat arrowW = 20;
    CGFloat arrowH = arrowW;
    CGFloat arrowY = (self.height-arrowH)*0.5;
    CGFloat arrowX = ScreenWidth-arrowW-marginLeft;
    arrow.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);
    [arrow setImage:[UIImage resizedImage:@"pay_arrowright"] forState:UIControlStateNormal];
    arrow.userInteractionEnabled = NO;
    [self addSubview:arrow];
    self.arrow = arrow;

}
- (void)setItem:(TableCellItemModel *)item{
    _item = item;
    //设置头像
    if (item.image) {
        self.header.layer.cornerRadius = 5.0f;
        self.header.layer.borderWidth  = 0.5f;
        self.header.layer.borderColor = [UIColor grayColor].CGColor;
        self.header.image = [UIImage imageWithData:item.image];
    }else{
        self.header.image = [UIImage imageNamed:item.icon];
    }
    //设置text
    self.text.text = item.title;
    //详细标题
    if (item.detailTitle) {
        self.detailText.hidden = NO;
        CGSize detailSize = [item.detailTitle sizeWithAttributes:@{NSFontAttributeName:MyFont(15)}];
        CGFloat detailW = detailSize.width;
        CGFloat detailH = detailSize.height;
        CGFloat detailY = (self.height-detailH)*0.5;
        CGFloat detailX = ScreenWidth-detailW-self.arrow.width-marginLeft;
        self.detailText.frame = CGRectMake(detailX, detailY, detailW, detailH);
        self.detailText.text = item.detailTitle;
   
    }
 
}
@end
