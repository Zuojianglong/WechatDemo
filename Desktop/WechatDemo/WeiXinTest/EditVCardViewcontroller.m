//
//  EditVCardViewcontroller.m
//  WeiXinTest
//
//  Created by long on 16/5/20.
//  Copyright © 2016年 long. All rights reserved.
//

#import "EditVCardViewcontroller.h"
#import "EditingCell.h"
#import "MyTextField.h"

#define EditCellID @"editingCell"
@interface EditVCardViewcontroller ()
@property (nonatomic,weak) MyTextField *inputTF;
@end

@implementation EditVCardViewcontroller
- (instancetype)init{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupNavButton];
    
    [self.tableView registerClass:[EditingCell class] forCellReuseIdentifier:EditCellID];
    
}
#pragma mark 添加导航按钮
- (void)setupNavButton{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame = CGRectMake(0, 0, 40, 30);
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    leftBtn.titleLabel.font = MyFont(14);
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    //2.添加右边的按钮
    UIButton *rightBtn=[[UIButton alloc]init];
    rightBtn.frame=CGRectMake(0, 0, 40, 30);
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    rightBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, -10);
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    rightBtn.titleLabel.font=MyFont(14);
    [rightBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark BarButtonClick
- (void)close{
    //取消
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)save{
    //保存
    if ([self.delegate respondsToSelector:@selector(EditingFinished:indexPath:newInfo:)]) {
        [self.delegate EditingFinished:self indexPath:self.indexPath newInfo:_inputTF.text];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    EditingCell *cell = [tableView dequeueReusableCellWithIdentifier:EditCellID forIndexPath:indexPath];
    cell.content = self.content;
    self.inputTF = cell.input;
    [self.inputTF becomeFirstResponder];
    
    return cell;
}
@end
