//
//  YWCHeartController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/16.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCHeartController.h"
//把角度转成弧度
#define angle2Radio(angle) ((angle) / 180.0 * M_PI)
@interface YWCHeartController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIImageView *iconV;

@end

@implementation YWCHeartController
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //1.创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    //2.设置动画的属性值
    anim.keyPath = @"transform.scale";
    anim.toValue = @(0);
    //让动画重复执
    anim.repeatCount = MAXFLOAT;
    
    //设置动画的执行时长
    anim.duration = 0.5;
    
    //自动反转(怎么去,怎么回来.)
    anim.autoreverses = YES;
    
    //3.添加动画
    [self.imageV.layer addAnimation:anim forKey:nil];
    
    
    
    
    //创建帧动画
    CAKeyframeAnimation *anim1 = [CAKeyframeAnimation animation];
    anim1.keyPath = @"position";
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 100)];
    [path addLineToPoint:CGPointMake(300, 100)];
    //    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 100, 200, 200)];
    //    anim.duration = 1;
    anim1.path = path.CGPath;
    
    
    //动画完成时,不要删除动画
    anim1.removedOnCompletion = NO;
    anim1.fillMode = kCAFillModeRemoved;
    
    [self.iconV.layer addAnimation:anim1 forKey:nil];
    
    [self iconAnim];
}


- (void)iconAnim{
    
    //创建帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    //设置动画的属性值.
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angle2Radio(-5)),@(angle2Radio(5)),@(angle2Radio(-5))];
    anim.duration = 0.15;
    anim.repeatCount = MAXFLOAT;
    
    //    anim.autoreverses = YES;
    [self.iconV.layer addAnimation:anim forKey:nil];
    
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
