


//
//  YWCQQViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/16.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCQQViewController.h"

@interface YWCQQViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@end

@implementation YWCQQViewController
static int _i = 1;
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    //创建动画对象
    CATransition *anim = [CATransition animation];
    
    anim.duration = 1;
    
    //设置转类型
    anim.type = @"pageCurl";
    //设置动画的起始点.
    anim.startProgress = 0.2;
    //设置动画的截至点.
    anim.endProgress = 0.5;
    
    [self.imageV.layer addAnimation:anim forKey:nil];
    
    
    //转场代码
    _i++;
    if(_i > 20){
        _i = 1;
    }
    NSString *imageName = [NSString stringWithFormat:@"%d",_i];
    self.imageV.image = [UIImage imageNamed:imageName];
    
    //转场动画必须得要跟转场代码在同一个方法当中.
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//   self.view.translatesAutoresizingMaskIntoConstraints = NO;
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
