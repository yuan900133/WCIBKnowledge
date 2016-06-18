//
//  YWCCutScreenController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/14.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCCutScreenController.h"

@interface YWCCutScreenController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
/** 手指在屏幕上的起始点*/
@property (nonatomic ,assign) CGPoint startP;


/** 显示的遮盖*/
@property (nonatomic, weak)  UIView *coverView ;
@end

@implementation YWCCutScreenController

-(UIView *)coverView{
    
    if (_coverView == nil) {
        
        UIView *coverView = [[UIView alloc] init];
        coverView.backgroundColor = [UIColor blackColor];
        coverView.alpha = 0.7;
        [self.view addSubview:coverView];
        _coverView = coverView;
    }
    return _coverView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageV.userInteractionEnabled = YES;
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imageV addGestureRecognizer:pan];
    
}


- (void)pan:(UIPanGestureRecognizer *)pan{
    
    //获取手指开始在屏幕上的点.
    CGPoint curP =  [pan locationInView:self.imageV];
    if(pan.state == UIGestureRecognizerStateBegan){
        self.startP = curP;
        
    }else if(pan.state == UIGestureRecognizerStateChanged){
        
        CGFloat x = self.startP.x;
        CGFloat y = self.startP.y;
        CGFloat width = curP.x - self.startP.x;
        CGFloat height = curP.y - self.startP.y;
        CGRect rect = CGRectMake(x, y, width, height);
        //添加遮盖,修改遮盖的位置大小.
        self.coverView.frame = rect;
    }else if(pan.state == UIGestureRecognizerStateEnded){
        
        //把超过遮盖以外的内容都给裁剪掉.
        //1.开启位图上下文.
        UIGraphicsBeginImageContextWithOptions(self.imageV.bounds.size, NO, 0);
        //2.把遮盖设置成裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.coverView.frame];
        //把路径设置成裁剪区域
        [path addClip];
        //3.把图片绘制到上下文当中.
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [self.imageV.layer renderInContext:ctx];
        //4.生成一个张图片.
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        //5.把新生成的图片重新给原始图片赋值.
        self.imageV.image = newImage;
        //6.关闭位图上下文.
        UIGraphicsEndImageContext();
        
        //移除遮盖
        [self.coverView removeFromSuperview];
    }
    
    
    
    
}

@end
