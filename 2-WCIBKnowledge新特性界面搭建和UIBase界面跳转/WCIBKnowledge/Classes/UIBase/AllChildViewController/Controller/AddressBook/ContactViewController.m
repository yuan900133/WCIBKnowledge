//
//  ContactViewController.m
//  05-私人通讯录(搭建登录界面)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "ContactViewController.h"
#import "Contact.h"
#import "AddViewController.h"
#import "EditViewController.h"
#define UpdateContactNote @"updateContact"
@interface ContactViewController ()<UIActionSheetDelegate,AddViewControllerDelegate>
/** 联系人数组*/
@property(nonatomic ,strong) NSMutableArray *contacts;

@end

@implementation ContactViewController
- (NSMutableArray *)contacts
{
    if (_contacts == nil) {
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}
- (void)setAccount:(NSString *)account
{
    _account = account;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@的联系人列表",_account];
}
// 点击注销按钮就会调用
- (IBAction)logout:(id)sender {
    
    // 弹出UIActionSheet
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定要注销?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"注销" otherButtonTitles:nil, nil];
    
    [sheet showInView:self.view];
}

#pragma mark -  UIActionSheetDelegate
// 点击UIActionSheet上的按钮就会调用
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",buttonIndex);
    if (buttonIndex == 0) {
        // 注销
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:UpdateContactNote object:nil];
    // 快速取消分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self.tableView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AddViewController class]]) {
        // 获取目的控制器(添加控制器)
        AddViewController *addVc =  segue.destinationViewController;
        
        addVc.delegate = self;
        
    }else{ // 进入编辑控制器
        EditViewController *editVc = segue.destinationViewController;
        
        // 获取选中的角标
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        editVc.contact = self.contacts[indexPath.row];
    }

}

#pragma mark - AddViewControllerDelegate
// 添加新的联系人就会调用
- (void)addViewController:(AddViewController *)addVc didAddContact:(Contact *)contact
{
    NSLog(@"%@",contact.name);
    // 保存联系人
    [self.contacts addObject:contact];
    
    // 刷新表格
    [self.tableView reloadData];
}
#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    Contact *c = self.contacts[indexPath.row];
    
    cell.textLabel.text = c.name;
    cell.detailTextLabel.text = c.phone;
    
    return cell;
}


@end
