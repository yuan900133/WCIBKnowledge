//
//  YWCClockViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/14.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCClockViewController.h"
//秒针每一秒旋转多少度.
#define perSecA 6

//每一分分针旋转多少度
#define perMinA 6

//每一小时, 时针旋转多少度
#define perHourA 30

//每一分,时针旋转多少度.
#define perMinHourA 0.5

//把角度转成弧度
#define angle2Radio(angle) ((angle) / 180.0 * M_PI)
@interface YWCClockViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *colockView;
/** 秒针*/
@property (nonatomic, weak)  CALayer *secLayer;

/** 分针*/
@property (nonatomic, weak)  CALayer *minLayer;

/** 时针*/
@property (nonatomic, weak)  CALayer *hourLayer;

@end

@implementation YWCClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加秒针
    [self setUpSec];
    [self setUpMin];
    [self setUpHour];
    
    //添加定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [self timeChange];
}

- (void)timeChange{
    
    //计算当前秒针旋转多少度.
    //拿到当前是多少秒,
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *cmp = [cal components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    //获取当前是多少秒
    NSInteger curSec = cmp.second;
    //获取当前是多少分
    NSInteger curMin = cmp.minute;
    //获取当前是多少小时
    NSInteger curHour = cmp.hour;
    //当前秒数 * perSecA
    //计算当前秒针旋转的角度
    CGFloat secAngle =  curSec * perSecA;
    self.secLayer.transform = CATransform3DMakeRotation(angle2Radio(secAngle), 0, 0, 1);
    
    //计算当前分针旋转的角度
    CGFloat minAngle =  curMin * perMinA;
    self.minLayer.transform = CATransform3DMakeRotation(angle2Radio(minAngle), 0, 0, 1);
    
    //计算当前时针旋转的角度
    CGFloat hourAngle =  curHour * perHourA + curMin * perMinHourA;
    self.hourLayer.transform = CATransform3DMakeRotation(angle2Radio(hourAngle), 0, 0, 1);
    
    
}

//添加秒针
- (void)setUpSec{
    //旋转,还是缩放都是绕着anchorPoint(锚点)进行.
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 1, 80);
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(self.colockView.bounds.size.width * 0.5, self.colockView.bounds.size.height * 0.5);
    self.secLayer = layer;
    [self.colockView.layer addSublayer:layer];
}

//添加分针
- (void)setUpMin{
    //旋转,还是缩放都是绕着anchorPoint(锚点)进行.
    CALayer *minLayer = [CALayer layer];
    minLayer.backgroundColor = [UIColor blackColor].CGColor;
    minLayer.bounds = CGRectMake(0, 0, 3, 70);
    minLayer.anchorPoint = CGPointMake(0.5, 1);
    minLayer.position = CGPointMake(self.colockView.bounds.size.width * 0.5, self.colockView.bounds.size.height * 0.5);
    self.minLayer = minLayer;
    [self.colockView.layer addSublayer:minLayer];
}


//添加分针
- (void)setUpHour{
    //旋转,还是缩放都是绕着anchorPoint(锚点)进行.
    CALayer *hourLayer = [CALayer layer];
    hourLayer.backgroundColor = [UIColor blackColor].CGColor;
    hourLayer.bounds = CGRectMake(0, 0, 3, 60);
    hourLayer.anchorPoint = CGPointMake(0.5, 1);
    hourLayer.position = CGPointMake(self.colockView.bounds.size.width * 0.5, self.colockView.bounds.size.height * 0.5);
    self.hourLayer = hourLayer;
    [self.colockView.layer addSublayer:hourLayer];
}




//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    [UIView animateWithDuration:0.5 animations:^{
//
//        self.secLayer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
//    }];
//}
@end
