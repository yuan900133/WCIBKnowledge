//
//  AddViewController.h
//  05-私人通讯录(搭建登录界面)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddViewController,Contact;
@protocol AddViewControllerDelegate <NSObject>

@optional
// 给代理传值
- (void)addViewController:(AddViewController *)addVc didAddContact:(Contact *)contact;

@end

//@class ContactViewController;

@interface AddViewController : UIViewController

/** */
//@property(nonatomic ,strong) ContactViewController *contactVc;

// 想要接收我的值,才需要成为我的代理
// 传值
@property(nonatomic , weak) id <AddViewControllerDelegate>delegate;

@end
