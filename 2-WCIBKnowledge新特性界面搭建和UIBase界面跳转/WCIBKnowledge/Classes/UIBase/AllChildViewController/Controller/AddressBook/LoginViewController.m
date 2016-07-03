//
//  LoginViewController.m
//  05-私人通讯录(搭建登录界面)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "LoginViewController.h"
#import <SVProgressHUD.h>
#import "ContactViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rmbPwdSwith;

@end

@implementation LoginViewController
/*
 传值步骤:
 1.接收方要有属性去接收
 
 2.传递方需要拿到接收方,给他传值
 
 顺传:来源控制器传值给目的控制器
 1.目的控制器有属性去接收
 2.来源控制器中拿到目的控制器传值
 */
// 账号:xmg 密码:123
// 点击登录按钮就会调用
- (IBAction)login:(id)sender {
    
    // 弹出蒙版
    [SVProgressHUD showWithStatus:@"正在拼命登录ing..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 隐藏蒙版
        [SVProgressHUD dismiss];
        
        // 判断下账号密码是否输入正确
        if ([_accountField.text isEqualToString:@"ywc"] && [_pwdField.text isEqualToString:@"123"]) { // 输入正确
            
            // 跳转到联系人界面
            [self performSegueWithIdentifier:@"login2Contact" sender:nil];
            /*
             1.创建segue对象,设置segue属性,来源控制器,目的控制器
             2.通知来源控制器,准备好segue
             3.[segue perform]
             3.1  [segue.sourceVC.navigationController pushViewController:segue.destVc animated:YES];
             */
            
            //            // 加载mainstroyboard
            //            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //
            //            // 创建联系人控制器
            //            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"contact"];
            //
            //            [self.navigationController pushViewController:vc animated:YES];

        }else{
            // 输入错误
            // 弹出框
            [SVProgressHUD showErrorWithStatus:@"账号或者密码输入错误"];
        }
    });
    
    
}

// 做数据之间传值
// 跳转之前,准备好segue的时候调用
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ContactViewController *contact = segue.destinationViewController;
    
    contact.account = _accountField.text;
    
}
// 当自动登录开关状态改变的时候就会调用
- (IBAction)autoLoginChange:(UISwitch *)sender {
    
    if (sender.on == YES) { // 勾选了自动登录
        // 勾选记住密码
        //        _rmbPwdSwith.on = YES;
        [_rmbPwdSwith setOn:YES animated:YES];
    }
}

// 当记住密码开关状态改变的时候就会调用
- (IBAction)rmbPwdChange:(UISwitch *)sender {
    // 判断下记住密码是否取消勾选,如果取消,需要取消勾选自动登录
    if (sender.on == NO) { // 取消勾选记住密码
        // 取消勾选自动登录
        [_autoLoginSwitch setOn:NO animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 当两个文本框有内容的时候,让按钮允许点击
    
    // 监听文本框的内容
    [self textChange];
    // 监听账号文本框
    //    _accountField.delegate = self;
    // 监听文本框内容改变
    [_accountField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [_pwdField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
}

// 账号或者密码文本框一改变就会调用
- (void)textChange
{
    //    if () {
    //        // 允许按钮点击
    //        _loginBtn.enabled = YES;
    //    }else{
    //        _loginBtn.enabled = NO;
    //    }
    _loginBtn.enabled = _accountField.text.length > 0 && _pwdField.text.length > 0;
    //    NSLog(@"%@",_accountField.text);
}

// 拦截用户输入
// 不能及时监听文本框内容改变
// 只要用户输入就会调用
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//
//    NSLog(@"%@",_accountField.text);
//    return YES;
//}

@end
