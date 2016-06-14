//
//  YWCwipeViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/14.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCwipeViewController.h"


@interface YWCwipeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@end

@implementation YWCwipeViewController
- (IBAction)pan:(UIPanGestureRecognizer *)pan{
    CGFloat rectWH = 30;
    //获取当前手指所在的点.
    CGPoint curP =[pan locationInView:pan.view];
    
    CGFloat x = curP.x - rectWH * 0.5;
    CGFloat y = curP.y - rectWH * 0.5;
    CGRect rect = CGRectMake(x,y,rectWH, rectWH);
    
    
    //1.开启一个位图上下文.
    UIGraphicsBeginImageContextWithOptions(self.imageV.bounds.size, NO, 0);
    //2.想要把UIImageV内容,绘制到上下文当中.
    //获取当前的上下文.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.imageV.layer renderInContext:ctx];
    //擦除上下文当中指定的区域
    CGContextClearRect(ctx, rect);
    
    //生成一张新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    self.imageV.image = newImage;
    
    UIGraphicsEndImageContext();
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


@end
