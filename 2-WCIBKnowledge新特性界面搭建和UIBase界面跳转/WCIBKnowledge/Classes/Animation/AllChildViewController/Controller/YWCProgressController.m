//
//  YWCProgressController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/13.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCProgressController.h"
#import "ProgressView.h"
@interface YWCProgressController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet ProgressView *progressV;


@end

@implementation YWCProgressController
- (IBAction)slider:(UISlider*)sender {
    NSLog(@"0000000000%f",sender.value);
    //stringWithFormat当中%有特殊的含义,所以不能够直接使用, 用两个%来代表一个%
    self.label.text = [NSString stringWithFormat:@"%.2f%%",sender.value * 100];
    self.progressV.progressValue = sender.value;
    NSLog(@"1111111111%f",sender.value);
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
