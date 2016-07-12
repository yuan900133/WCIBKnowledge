//
//  YWCDragSubController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/12.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCDragSubController.h"

@implementation YWCDragSubController
- (void)viewDidLoad {
    [super viewDidLoad];
    //当一个控制器View添加另一个控制器的View上面, 那么你当前的这个控制器.也要它的子控制器.
   UITableViewController *tableV =   [[UITableViewController alloc] init];
    tableV.view.frame = self.mainV.bounds;
    [self.mainV addSubview:tableV.view];
    [self addChildViewController:tableV];
    
    
    UITableViewController *tableV2 =   [[UITableViewController alloc] init];
    tableV2.view.frame = self.leftV.bounds;
    tableV2.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"18"]];
    [self.leftV addSubview:tableV2.view];
    [self addChildViewController:tableV2];
}

@end
