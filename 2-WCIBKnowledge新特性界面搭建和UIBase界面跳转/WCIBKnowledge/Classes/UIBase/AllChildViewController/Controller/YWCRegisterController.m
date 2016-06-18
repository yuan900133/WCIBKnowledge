//
//  YWCRegisterController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/11.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCRegisterController.h"
#import "FlagField.h"
@interface YWCRegisterController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *flagField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;

@end

@implementation YWCRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 监听3个文本框输入
    
    // 国旗文本框
    _flagField.delegate = self;
    
    // 生日文本框
    _birthdayField.delegate = self;
    
    // 城市文本框
    _cityField.delegate = self;
    
}
#pragma mark -UITextFieldDelegate

#pragma mark -UITextFieldDelegate
// 当文本框开始编辑的时候调用
- (void)textFieldDidBeginEditing:(FlagField *)textField
{
    
    
    // 编译特性:声明什么,编译就认为是什么
    // 运行特性:调用方法的时候,才会去查找真实类型
    //    textField.text = @"中国";
    [textField initialText];
    
    // 初始化文本框
    //    NSLog(@"%@",textField);
}

// 是否允许用户输入
// 拦截用户输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.flagField resignFirstResponder];
    [self.birthdayField resignFirstResponder];
    [self.cityField resignFirstResponder];
    
}
@end
