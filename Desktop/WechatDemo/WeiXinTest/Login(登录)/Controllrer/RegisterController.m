//
//  RegisterController.m
//  WeiXinTest
//
//  Created by long on 16/5/18.
//  Copyright © 2016年 long. All rights reserved.
//

#import "RegisterController.h"
#import "MyTextField.h"
#import "MyTabBarController.h"

#define commonMargin 20
#define marginX 20
#define textFieldWidth  (ScreenWidth-2*marginX)
#define textFieldHeight 30

@interface RegisterController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIButton *registerBtn;
@property (nonatomic,strong) MyTextField *userName;
@property (nonatomic,strong) MyTextField *password;
@end

@implementation RegisterController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupChildView];
    
    
}
- (void)setupChildView{
    
    MyTextField *user = [MyTextField new];
    user.delegate = self;
    user.frame = CGRectMake(marginX, commonMargin, textFieldWidth, textFieldHeight);
    user.image = @"biz_pc_main_info_profile_login_user_icon";
    user.customPlaceholder = @"请输入用户名/手机号/QQ号";
    [self.view addSubview:user];
    self.userName = user;
    //添加线
    CGFloat lineY = commonMargin+textFieldHeight+10;
    [self addbottomLineWithbounds:CGRectMake(marginX, lineY, textFieldWidth, 0.5)];
    //密码输入框
    CGFloat passY = lineY+10;
    MyTextField *psd = [MyTextField new];
    psd.frame = CGRectMake(marginX, passY, textFieldWidth,textFieldHeight);
    psd.delegate = self;
    psd.image = @"biz_pc_main_info_profile_login_pw_icon";
    psd.customPlaceholder = @"请输入密码";
    [self.view addSubview:psd];
    self.password = psd;
    //添加下划线
    CGFloat nextLineY = passY+textFieldHeight+10;
    [self addbottomLineWithbounds:CGRectMake(marginX, nextLineY, textFieldWidth, 0.5)];
    //注册按钮
    CGFloat regBtnY = nextLineY+20;
    [self addRegisterBtnWithBounds:CGRectMake(marginX, regBtnY, textFieldWidth, 40)];
    
    

    
    
}
#pragma mark 添加下划线
- (void)addbottomLineWithbounds:(CGRect)bounds{
    UIView *line = [[UIView alloc]initWithFrame:bounds];
    line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:line];
    
}
#pragma mark 添加注册按钮
- (void)addRegisterBtnWithBounds:(CGRect)bounds{
    
    UIButton *regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regBtn.frame = bounds;
    regBtn.enabled = NO;
    [regBtn setTitle:@"注册" forState:UIControlStateNormal];
    [regBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [regBtn setTitleColor:LGColorAlpha(255, 255, 255, 0.5) forState:UIControlStateDisabled];
    [regBtn setBackgroundImage:[UIImage resizedImage:@"fts_green_btn"] forState:UIControlStateNormal];
    [regBtn setBackgroundImage:[UIImage resizedImage:@"fts_green_btn_HL"] forState:UIControlStateHighlighted];
    [regBtn setBackgroundImage:[UIImage resizedImage:@"GreenBigBtnDisable"] forState:UIControlStateDisabled];
    [regBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regBtn];
    self.registerBtn = regBtn;
    
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (self.userName.text.length != 0 && self.password.text.length != 0) {
        
        self.registerBtn.enabled = YES;
        
    }else{
        
        self.registerBtn.enabled = NO;
    }

    
    if (range.location>=15) {
        
        return NO;
    }
        
        return YES;

}

#pragma mark 注册按钮的事件
- (void)registerBtnClick{
    NSString *uname = self.userName.text.deleteSpace;
    NSString *pass = self.password.text.deleteSpace;
    //登录的方法
    UserOperation *user = [UserOperation shareduser];
    user.uname = uname;
    user.password = pass;
    XMPPTools *tool = [XMPPTools sharedxmpp];
    tool.registerOperation = YES;
    __weak typeof(self) weakSelf = self;
    //显示hud
    [BaseMethod showMessage:@"注册中" toView:self.view];
    [tool regist:^(XMPPResultType xmppType) {
        [weakSelf handle:xmppType];
        
    }];
    
    
}
#pragma mark 用户登录验证的方法
- (void)handle:(XMPPResultType)type{
    //回到主线程
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [BaseMethod hideFormView:self.view];
        switch (type) {
            case XMPPResultSuccess:
                [BaseMethod showSuccess:@"恭喜您,注册成功" toView:self.view];
                [self enterHomeView];
                break;
            case XMPPResultFaiture:
                [BaseMethod showError:@"抱歉,注册失败,请重试..." toView:self.view];
                break;
            case XMPPResultNetworkErr:
                [BaseMethod showError:@"网络异常" toView:self.view];
                break;
                
            default:
                break;
        }
        
    });
    
}
#pragma mark 登录成功后进入主界面
-(void)enterHomeView
{
    UserOperation *user=[UserOperation shareduser];
    user.loginStatus=YES; //登录成功保存登录状态
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    MyTabBarController *tab=[[MyTabBarController alloc]init];
    [self presentViewController:tab animated:NO completion:nil];
    
    
}
@end
