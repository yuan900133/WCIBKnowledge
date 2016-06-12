
//
//  EditViewController.m
//  05-私人通讯录(搭建登录界面)
//
//  Created by 袁武昌 on 16/5/17.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "EditViewController.h"

#import "Contact.h"
#define UpdateContactNote @"updateContact"
@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;


@end

@implementation EditViewController
// 点击编辑就会调用
- (IBAction)edit:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"编辑"]) {
        // 1.允许文本框开始编辑
        _nameField.enabled = YES;
        _phoneField.enabled = YES;
        // 2.弹出电话文本框的键盘
        [_phoneField becomeFirstResponder];
        // 3.显示保存按钮
        _saveBtn.hidden = NO;
        
        // 4.修改按钮文字
        sender.title = @"取消";
        
    }else{  // 点击取消
        // 1.恢复文本框内容
        _nameField.text = _contact.name;
        _phoneField.text = _contact.phone;
        // 2.保存按钮隐藏
        _saveBtn.hidden = YES;
        // 3.文本框不允许编辑
        _nameField.enabled = NO;
        _phoneField.enabled = NO;
        // 4.修改文字
        sender.title = @"编辑";
    }
}
- (IBAction)saveContact:(id)sender {
    // 1.更新模型
    _contact.name = _nameField.text;
    _contact.phone = _phoneField.text;
    
    // 2.跳转到联系人界面
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    // 3.通知联系人刷新表格
    [[NSNotificationCenter defaultCenter] postNotificationName:UpdateContactNote object:nil];
}

- (void)setContact:(Contact *)contact
{
    _contact = contact;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 注意点:控制器之间传值.一般都是在viewDidLoad中给子控件赋值
    // 为什么?因为只有控制器的view加载完成,子控件才有值,而且数据在跳转之前就已经传过来
    // 给文本框赋值
    _nameField.text = _contact.name;
    _phoneField.text = _contact.phone;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
