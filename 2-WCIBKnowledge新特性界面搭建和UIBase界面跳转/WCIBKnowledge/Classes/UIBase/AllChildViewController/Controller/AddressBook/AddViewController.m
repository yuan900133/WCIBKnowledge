//
//  AddViewController.m
//  05-私人通讯录(搭建登录界面)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "AddViewController.h"
#import "Contact.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;


@end

@implementation AddViewController
/*
 传值步骤:
 1.接收方要有属性去接收
 
 2.传递方需要拿到接收方,给他传值
 
 顺传:来源控制器传值给目的控制器
 1.目的控制器有属性去接收
 2.来源控制器中拿到目的控制器传值
 
 逆传:目的控制器传值来源控制器
 1.在来源控制器跳转到目的控制器之前,就让目的控制器拿到来源控制器
 */
- (IBAction)add:(id)sender {
    // 把文本框的内容包装成模型
    Contact *c = [Contact contactWithName:_nameField.text phone:_phoneField.text];
    
    // 通知代理接收值
    if ([_delegate respondsToSelector:@selector(addViewController:didAddContact:)]) {
        [_delegate addViewController:self didAddContact:c];
    }
    
    
    // 回到上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 监听文本框内容改变
    [_nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [_phoneField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
}

// 账号或者密码文本框一改变就会调用
- (void)textChange
{
    _addBtn.enabled = _nameField.text.length > 0 && _phoneField.text.length > 0;
}
@end
