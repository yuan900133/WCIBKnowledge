
//
//  YWCTabBarController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/5.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCTabBarController.h"
#import "YWCNavigationController.h"

#import "YWCUIBaseController.h"
#import "YWCAnimationController.h"
#import "YWCNetWorkController.h"
#import "YWCPracticalController.h"
#import "YWCActualController.h"

#define YWCTabBarButtonTitleFont [UIFont systemFontOfSize:15]
@interface YWCTabBarController ()

@end

@implementation YWCTabBarController

+ (void)load
{
    // 获取当前类中的所有tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 1.设置默认状态下的标题字体
    // 1.1描述字符串的属性
    NSMutableDictionary *attrNor = [NSMutableDictionary dictionary];
    // 1.2设置标题字体大小
    attrNor[NSFontAttributeName] = YWCTabBarButtonTitleFont;
    [item setTitleTextAttributes:attrNor forState:UIControlStateNormal];
    
    // 2.设置tabBarButton按钮选中标题颜色
    // 2.1 描述字符串的属性
    NSMutableDictionary *attrSel = [NSMutableDictionary dictionary];
    // 2.2 设置字体颜色
    attrSel[NSForegroundColorAttributeName] = YWCRandomColor;
    // 设置选中状态下的标题颜色
    [item setTitleTextAttributes:attrSel forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = YWCRandomColor;
    //添加所有的子控制器
    [self setUpAllChildViewController];
    
}
//添加所有的子控制器
- (void)setUpAllChildViewController{
    
    //UI基础
    YWCUIBaseController *uiBase = [[YWCUIBaseController alloc] init];
    [self setUpOneChildViewController:uiBase image:[UIImage imageNamed:@"tabbar_home"] selectImage:[UIImage imageNamed:@"tabbar_home_highlighted"] title:@"UI基础"];
    
    //动画
    YWCAnimationController *animation = [[YWCAnimationController alloc] init];
    [self setUpOneChildViewController:animation image:[UIImage imageNamed:@"tabbar_me"] selectImage:[UIImage imageNamed:@"tabbar_me_highlighted"] title:@"动画"];
   

    //网络多线程
    YWCNetWorkController *netWork = [[YWCNetWorkController alloc] init];
    [self setUpOneChildViewController:netWork image:[UIImage imageNamed:@"tabbar_message_center"] selectImage:[UIImage imageNamed:@"tabbar_message_center_highlighted"] title:@"网络多线程"];
    
    
    //实战技术
    YWCPracticalController *practical = [[YWCPracticalController alloc] init];
    [self setUpOneChildViewController:practical image:[UIImage imageNamed:@"tabbar_me"] selectImage:[UIImage imageNamed:@"tabbar_me_highlighted"] title:@"实战技术"];
    //实用技术
    YWCActualController *actual = [[YWCActualController alloc] init];
    [self setUpOneChildViewController:actual image:[UIImage imageNamed:@"tabbar_active"] selectImage:[UIImage imageNamed:@"tabbar_active_highlighted"] title:@"实用技术"];
    
}

/** 添加一个子控制器方法*/
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)norImage selectImage:(UIImage *)selectImage title:(NSString *)title{
    
    vc.title = title;
    vc.tabBarItem.image = norImage;
    vc.tabBarItem.selectedImage = selectImage;
    
    YWCNavigationController  *nav = [[YWCNavigationController alloc]initWithRootViewController:vc];
    //    设置导航条文字属性
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:YWCRandomColor}];
    
    [self addChildViewController:nav];
    
}

@end
