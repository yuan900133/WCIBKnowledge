//
//  YWCRootTool.m
//  zhaosuliaowang
//
//  Created by yuan on 16/3/12.
//  Copyright © 2016年 yuan. All rights reserved.
//

#import "YWCRootTool.h"
#import "YWCTabBarController.h"
#import "YWCNewFCollectionViewController.h"
#define YWCVersionKey @"versionKey"
#import "YWCSaveTool.h"

@implementation YWCRootTool

/**
 *  专门用来选择根控制器
 *  选择好的根控制器.
 */
+ (UIViewController *)choosRootViewController{
    
    //获取当前程序的版本号
    NSString *curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    NSString *preVersion = [YWCSaveTool objectForKey:YWCVersionKey];
    //1.比对上次一次版本号.
    if ([curVersion isEqualToString:preVersion]) {
        //如果发现与上一次的版本号相同.tabBarVC(程序的主框架)
        YWCTabBarController *tabBarVC = [[YWCTabBarController alloc] init];
        return tabBarVC;
    }else{
        //如果发现与上一次的版本不同.跳转到新特性界面.
        YWCNewFCollectionViewController *newFeature = [[YWCNewFCollectionViewController alloc] init];
       
        [YWCSaveTool setObject:curVersion forKey:YWCVersionKey];
        return newFeature;
    }
}


@end
