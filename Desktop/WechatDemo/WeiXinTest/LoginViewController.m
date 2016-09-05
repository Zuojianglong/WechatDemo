//
//  LoginViewController.m
//  WeiXinTest
//
//  Created by long on 16/5/17.
//  Copyright © 2016年 long. All rights reserved.
//

#import "LoginViewController.h"
#import "MyTextField.h"
#import "RegisterController.h"
#import "MyTabBarController.h"

#define commomMargin    20
#define marginX         20
#define textFiledWidth  (ScreenWidth-marginX*2)
#define textFiledHeight 30
@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) MyTextField *userName;
@property (nonatomic,strong) MyTextField *psw;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *registerBtn;
@end

@implementation LoginViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"微信登录";
    [self setupChild];
    
    
    
}
- (void)setupChild{
    //账号文本框
    MyTextField *username = [MyTextField new];
    username.delegate = self;
    username.frame = CGRectMake(marginX, commomMargin, textFiledWidth, textFiledHeight);
    username.image = @"biz_pc_main_info_profile_login_user_icon";
    username.customPlaceholder = @"请输入用户名/手机号/QQ号";
    //username.placeholder = @"请输入用户名/手机号/QQ号";
    [self.view addSubview:username];
    self.userName = username;
    //下划线
    CGFloat lineY = commomMargin+textFiledHeight+10;
    [self addLineWithBounds:CGRectMake(marginX, lineY, textFiledWidth, 0.5)];
    
    MyTextField *password = [[MyTextField alloc]init];
    password.secureTextEntry = YES;
    password.delegate = self;
    CGFloat passwordY = commomMargin+textFiledHeight+20;
    password.frame = CGRectMake(marginX, passwordY, textFiledWidth, textFiledHeight);
    password.image = @"biz_pc_main_info_profile_login_pw_icon";
    password.customPlaceholder = @"请输入密码";
    [self.view addSubview:password];
    self.psw = password;
    
    CGFloat nextLineY = passwordY+textFiledHeight+10;
    [self addLineWithBounds:CGRectMake(marginX, nextLineY, textFiledWidth, 0.5)];
    
    //登录按钮
    CGFloat loginBtnY = nextLineY+20;
    [self addLoginButtonWithBounds:CGRectMake(marginX, loginBtnY, textFiledWidth, textFiledHeight)];
    //添加忘记密码?
    CGFloat fPswY = loginBtnY+textFiledHeight+10;
    CGFloat fPswX = marginX+10;
    [self addForgetPswBtnWithBounds:CGRectMake(fPswX, fPswY, 80, 30)];
    
    
    //添加注册按钮
    CGFloat regW = 40;
    CGFloat regH = 30;
    CGFloat regX = (ScreenWidth -regW)*0.5;
    CGFloat regY = self.view.height-64-regH-10;
    
    [self addRegisterbtnWithbounds:CGRectMake(regX, regY, regW, regH)];
    
}
#pragma mark 添加下划线
- (void)addLineWithBounds:(CGRect)bounds{
    
    UIView *line = [[UIView alloc]initWithFrame:bounds];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
}
#pragma mark 添加登录按钮
- (void)addLoginButtonWithBounds:(CGRect)bounds{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = bounds;
    btn.enabled = NO;
    [btn setBackgroundImage:[UIImage resizedImage:@"fts_green_btn"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizedImage:@"fts_green_btn_HL"] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage resizedImage:@"GreenBigBtnDisable"] forState:UIControlStateDisabled];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:LGColorAlpha(255, 255, 255, 0.5) forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.loginBtn = btn;
    
}
#pragma mark 添加忘记密码
- (void)addForgetPswBtnWithBounds:(CGRect)bounds{
    UIButton *forgetPsw = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPsw.frame = bounds;
    [forgetPsw setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPsw setTitleColor:LGColorAlpha(71, 61, 139, 0.8) forState:UIControlStateNormal];
    [forgetPsw setTitleColor:LGColorAlpha(0, 255, 255, 1) forState:UIControlStateHighlighted];
    forgetPsw.titleLabel.font = MyFont(14);
    [forgetPsw addTarget:self action:@selector(forgetPswBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPsw];
    
}

#pragma mark 添加注册按钮
- (void)addRegisterbtnWithbounds:(CGRect)bounds{
    
    UIButton *reg =[UIButton buttonWithType:UIButtonTypeCustom];
    reg.frame = bounds;
    reg.titleLabel.font = MyFont(14);
    [reg setTitle:@"注册" forState:UIControlStateNormal];
    [reg setTitleColor:LGColorAlpha(71, 61, 139, 0.8) forState:UIControlStateNormal];
    [reg setTitleColor:LGColorAlpha(0, 255, 255, 1) forState:UIControlStateHighlighted];
    [reg addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reg];
    self.registerBtn = reg;
    
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (self.userName.text.length != 0 && self.psw.text.length != 0) {
        self.loginBtn.enabled = YES;
    }else{
        self.loginBtn.enabled = NO;
    }
    if (range.location>=15) {
        
        return NO;
    }
    
    return YES;
}

#pragma mark 登录按钮事件
- (void)loginClick{
    //登录按钮方法
    
    NSString *uname = self.userName.text.deleteSpace;
    NSString *password = self.psw.text.deleteSpace;
    UserOperation *user = [UserOperation shareduser];
    user.uname = uname;
    user.password = password;
    
    XMPPTools *tool = [XMPPTools sharedxmpp];
    tool.registerOperation = NO;
    [BaseMethod showMessage:@"登录中..." toView:self.view];
    [self.view endEditing:YES];
    
    __weak typeof(self) weakSelf = self;
    [tool login:^(XMPPResultType xmppType) {
        //登录
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
                [BaseMethod showSuccess:@"登陆成功" toView:self.view];
                [self enterHomeView];
                break;
            case XMPPResultFaiture:
                [BaseMethod showError:@"用户名或密码错误" toView:self.view];
                break;
            case XMPPResultNetworkErr:
                [BaseMethod showError:@"网络不给力" toView:self.view];
                break;
                
            default:
                break;
        }
        
    });
    
}
- (void)enterHomeView{
    UserOperation *user = [UserOperation shareduser];
    user.loginStatus = YES;//登录成功不用再次登录
    self.userName.text = nil;
    self.psw.text = nil;
    
    [self dismissViewControllerAnimated:NO completion:nil];
    MyTabBarController *tab = [MyTabBarController new];
    [self presentViewController:tab animated:NO completion:nil];
    
    
}
#pragma mark 忘记密码按钮事件
- (void)forgetPswBtnClick{
    
    //点击忘记密码执行的方法
}
#pragma mark 注册按钮事件
- (void)registerBtnClick{
    
    RegisterController *reg = [RegisterController new];
    [self.navigationController pushViewController:reg animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
}
- (void)dealloc{
    
    NSLog(@"登录视图控制器消失了");
}
@end
