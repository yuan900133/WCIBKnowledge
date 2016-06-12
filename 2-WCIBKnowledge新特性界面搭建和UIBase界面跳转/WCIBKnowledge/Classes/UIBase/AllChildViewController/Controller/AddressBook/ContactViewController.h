//
//  ContactViewController.h
//  05-私人通讯录(搭建登录界面)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;
@interface ContactViewController : UITableViewController
@property (nonatomic, strong) NSString *account;
/** contact*/
@property(nonatomic ,strong) Contact *contact;
@end
