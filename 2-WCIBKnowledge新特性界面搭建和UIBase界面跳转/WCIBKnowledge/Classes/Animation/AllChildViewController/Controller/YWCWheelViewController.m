
//
//  YWCWheelViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/16.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCWheelViewController.h"
#import "WheelView.h"
@interface YWCWheelViewController ()
@property (nonatomic, weak)  WheelView *wheel;
@end

@implementation YWCWheelViewController
- (IBAction)start:(id)sender {
    [self.wheel start];
}
- (IBAction)stop:(id)sender {
    [self.wheel stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WheelView *wheel = [WheelView wheelView];
    wheel.center = self.view.center;
    self.wheel = wheel;
    [self.view addSubview:wheel];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _wheel.center = self.view.center;
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
