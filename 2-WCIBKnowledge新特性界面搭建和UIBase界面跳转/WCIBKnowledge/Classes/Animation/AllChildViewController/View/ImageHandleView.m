
//
//  ImageHandleView.m
//  11-画板(界面搭建)
//
//  Created by 袁武昌 on 16/5/21.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "ImageHandleView.h"

@interface ImageHandleView()<UIGestureRecognizerDelegate>


@property (nonatomic, weak) UIImageView *imageV;

@end

@implementation ImageHandleView


-(UIImageView *)imageV{
    if (_imageV == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = self.bounds;
        imageV.userInteractionEnabled = YES;
        [self addSubview:imageV];
        _imageV = imageV;
        [self setUpGes:imageV];
        
    }
    return _imageV;
}




// 添加UIImageView所有的手势
- (void)setUpGes:(UIImageView *)imageV
{
    // pan
    // 拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(pan:)];
    
    [imageV addGestureRecognizer:pan];
    
    // pinch
    // 捏合
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    
    pinch.delegate = self;
    [imageV addGestureRecognizer:pinch];
    
    
    //添加旋转
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    
    [imageV addGestureRecognizer:rotation];
    
    // 长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [imageV addGestureRecognizer:longPress];
}


//捏合的时候调用.
- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    
    pinch.view.transform = CGAffineTransformScale( pinch.view.transform, pinch.scale, pinch.scale);
    // 复位
    pinch.scale = 1;
}


//旋转的时候调用
- (void)rotation:(UIRotationGestureRecognizer *)rotation
{
    // 旋转图片
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.rotation);
    
    // 复位,只要想相对于上一次旋转就复位
    rotation.rotation = 0;
    
}


//长按的时候调用
// 什么时候调用:长按的时候调用,而且只要手指不离开,拖动的时候会一直调用,手指抬起的时候也会调用
- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    //让图片闪一下之后, 绘制到画板上去.
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        [UIView animateWithDuration:0.25 animations:^{
            longPress.view.alpha = 0;
        }completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.25 animations:^{
                longPress.view.alpha = 1;
            }completion:^(BOOL finished) {
                
                //把当前的View做一个截屏
                //1.开启一个位图上下文.
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
                //2.把当前View的layer渲染到上下文当中.
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                [self.layer renderInContext:ctx];
                //3.生成一张图片
                UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
                //4.把图片传给控制器
                //通知代理
                if([self.delegate respondsToSelector:@selector(imageHandleView:newImage:)]){
                    [self.delegate imageHandleView:self newImage:newImage];
                }
                
                //5.关闭上下文.
                UIGraphicsEndImageContext();
                //6.把当前的View移除父控件.
                [self removeFromSuperview];
                
                
                
            }];
            
        }];
        
        
    }
    
    
}




//拖动的时候调用
- (void)pan:(UIPanGestureRecognizer *)pan{
    
    CGPoint transP = [pan translationInView:pan.view];
    
    
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, transP.x, transP.y);
    //复位
    [pan setTranslation:CGPointZero inView:pan.view];
    
    
}


//能够同时支持多个手势
-(BOOL)gestureRecognizer:(nonnull UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}

-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageV.image = image;
}


@end
