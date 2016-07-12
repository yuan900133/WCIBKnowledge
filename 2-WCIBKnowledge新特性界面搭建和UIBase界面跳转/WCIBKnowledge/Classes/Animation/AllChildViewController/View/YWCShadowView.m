
//
//  YWCShadowView.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/16.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCShadowView.h"
@interface YWCShadowView()

/** 当前绘制的路径 */
@property(nonatomic ,strong) UIBezierPath *path;

/** 当前的粒子*/
@property (nonatomic, weak)  CALayer *dotLayer;

@end
@implementation YWCShadowView
//返回当前View层的类型
+(Class)layerClass{
    return [CAReplicatorLayer class];
}
-(void)awakeFromNib{
    
    CAReplicatorLayer *repL = (CAReplicatorLayer *)self.layer;
    repL.instanceCount = 60;
    repL.instanceDelay = 0.25;
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    //创建一个粒子
    CALayer *dotLayer = [CALayer layer];
    dotLayer.frame = CGRectMake(-10, 0, 10, 10);
    dotLayer.backgroundColor = [UIColor redColor].CGColor;
    self.dotLayer = dotLayer;
    [self.layer addSublayer:dotLayer];
    
    //创建路径.
    UIBezierPath *path = [UIBezierPath bezierPath];
    self.path = path;
}


- (void)pan:(UIPanGestureRecognizer *)pan{
    
    //获取当前手指的点.
    CGPoint curP = [pan locationInView:self];
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        //设置路径的起点
        [self.path moveToPoint:curP];
    }else if(pan.state == UIGestureRecognizerStateChanged){
        //添加一根线到当前手指所在的点.
        [self.path addLineToPoint:curP];
        //重绘
        [self setNeedsDisplay];
    }
    
}



//开始动画
- (void)start{
    
    //创建一个帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.path = self.path.CGPath;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 3;
    //把动画添加给粒子
    [self.dotLayer addAnimation:anim forKey:nil];
    
}
//重绘
- (void)redraw{
    
    //移除动画
    [self.dotLayer removeAllAnimations];
    //清空路径
    [self.path removeAllPoints];
    //重绘
    [self setNeedsDisplay];
}



- (void)drawRect:(CGRect)rect {
    
    [self.path stroke];
    
}

@end
