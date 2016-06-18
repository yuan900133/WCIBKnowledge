
//
//  YWCFoldViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/16.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCFoldViewController.h"

@interface YWCFoldViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageV;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageV;

@property (weak, nonatomic) IBOutlet UIView *dragView;
@property (nonatomic, weak)  CAGradientLayer *gradient;


@property (weak, nonatomic) IBOutlet UIView *contentView;
@end

@implementation YWCFoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //让上部图片只显示上半部分
    self.topImageV.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    //设置上部图片的锚点
    self.topImageV.layer.anchorPoint = CGPointMake(0.5, 1);
    //让下部图片只显示下半部分
    self.bottomImageV.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    //修改下部图片的锚点
    self.bottomImageV.layer.anchorPoint = CGPointMake(0.5, 0);
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.dragView addGestureRecognizer:pan];
    
    //渐变层
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bottomImageV.bounds;
    //设置渐变的颜色
    gradient.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
    //    //设置渐变的方向
    //    gradient.startPoint = CGPointMake(0, 0);
    //    gradient.endPoint = CGPointMake(1, 0);
    //
    //设置从哪个点渐变到下一个点.
    //    gradient.locations = @[@0.3,@0.8];
    //设置图层的不透明度
    gradient.opacity = 0;
    self.gradient = gradient;
    [self.bottomImageV.layer addSublayer:gradient];
    
    [self music];
}

- (void)music
{
    //复制层
    CAReplicatorLayer *repL = [CAReplicatorLayer layer];
    repL.frame = self.contentView.bounds;
    //要复制4份(包括它自己)
    repL.instanceCount = 4;
    //平移
    repL.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
    //设置动画的延时
    //下个动画相对于上一个动画的延时
    repL.instanceDelay = 1;
    [self.contentView.layer addSublayer:repL];
    
    //创建音量震动条
    CALayer *layer = [CALayer layer];
    //    layer.frame = CGRectMake(0, self.contentView.bounds.size.height - 100, 30, 100);
    layer.bounds = CGRectMake(0, 0, 30, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.anchorPoint = CGPointMake(0, 1);
    layer.position = CGPointMake(0, self.contentView.bounds.size.height);
    [repL addSublayer:layer];
    
    //添加动画(缩放动画)
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @0;
    anim.repeatCount = MAXFLOAT;
    anim.autoreverses = YES;
    anim.duration = 1;
    [layer addAnimation:anim forKey:nil];
}


//渐变层
- (void)gradientLayer{
    
    //渐变层
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bottomImageV.bounds;
    //设置渐变的颜色
    gradient.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
    //设置渐变的方向
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    
    //设置从哪个点渐变到下一个点.
    gradient.locations = @[@0.3,@0.8];
}


- (void)pan:(UIPanGestureRecognizer *)pan{
    
    CGPoint transP =  [pan translationInView:self.dragView];
    //让上半部分图片进行绕着x轴进行旋转
    CGFloat angle = transP.y * M_PI / 200.0;
    //近大远小.
    CATransform3D transform =  CATransform3DIdentity;
    //后面参数,眼睛离屏幕的距离.
    transform.m34 = -1 / 300.0;
    
    //修渐变层的不透明度
    self.gradient.opacity = transP.y * 1 / 200.0;
    
    //    self.topImageV.layer.transform = CATransform3DMakeRotation(-angle, 1, 0, 0);
    self.topImageV.layer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0);
    
    
    //判断手指松开
    if(pan.state == UIGestureRecognizerStateEnded){
        
        self.gradient.opacity = 0;
        
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.25 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            //复位.
            //清空形变
            self.topImageV.layer.transform = CATransform3DIdentity;
            
        } completion:nil];
    }
    
    
    
    
}
@end
