
//
//  BageValue.m
//  12-QQ粘性布局(界面搭建,小圆缩放)
//
//  Created by 袁武昌 on 16/5/22.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "BageValue.h"

@interface BageValue()

/** 底部的小圆*/
@property (nonatomic, weak) UIView *smallCircle;
/** 形状图层*/
@property (nonatomic, weak) CAShapeLayer *shap;
@end

@implementation BageValue
-(CAShapeLayer *)shap{
    
    if (_shap == nil) {
        //形状图层,根据一个路径,产生一个形状.形状的大小, 跟路径的大小是一样的.
        CAShapeLayer *shap = [CAShapeLayer layer];
        //设置填充颜色
        shap.fillColor = [UIColor redColor].CGColor;
        //把形状图层添加到一个层里面.
        [self.superview.layer insertSublayer:shap atIndex:0];
        
        _shap = shap;
    }
    return _shap;
}


-(void)awakeFromNib{
    [self setUp];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
    
}




- (void)setUp{
    
    //设置背景颜色
    self.backgroundColor = [UIColor redColor];
    //设置文字的颜色
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //文字的大小.
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    //设置圆角
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    //添加底部的小圆
    UIView *smallCircle = [[UIView alloc] init];
    smallCircle.frame = self.frame;
    smallCircle.backgroundColor = self.backgroundColor;
    smallCircle.layer.cornerRadius = self.layer.cornerRadius;
    self.smallCircle = smallCircle;
    //    [self.superview addSubview:smallCircle];
    //把一个View插入到指定View下部.
    [self.superview insertSubview:smallCircle belowSubview:self];
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    //获取移动的偏移量
    CGPoint transP = [pan translationInView:self];
    //frame,center,transform.
    //transform它并没有去修改center,transform是修改frame.
    //    self.transform = CGAffineTransformTranslate(self.transform, transP.x, transP.y);
    
    CGPoint center = self.center;
    center.x += transP.x;
    center.y += transP.y;
    self.center = center;
    
    //复位
    [pan setTranslation:CGPointZero inView:self];
    CGFloat distance = [self distanceWithSmallCircle:self.smallCircle bigCircle:self];
    
    //每一次来的时候,让小圆的半径在减小.
    CGFloat smallR = self.bounds.size.width * 0.5;
    smallR = smallR - distance / 10.0;
    self.smallCircle.bounds = CGRectMake(0, 0, smallR * 2, smallR * 2);
    self.smallCircle.layer.cornerRadius = smallR;
    
    NSLog(@"%f",distance);
    
    if (self.smallCircle.hidden == NO) {
        UIBezierPath *path = [self pathWithSmallCircle:self.smallCircle bigCircle:self];
        self.shap.path = path.CGPath;
    }
    
    //如果两个圆之间的距离, 超过某个值时, 小圆隐藏,形状移除
    if(distance > 60){
        self.smallCircle.hidden = YES;
        [self.shap removeFromSuperlayer];
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        //如果两个圆之间的距离小于60,做复位操作
        if (distance < 60) {
            [self.shap removeFromSuperlayer];
            [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.center = self.smallCircle.center;
            } completion:^(BOOL finished) {
                //让小圆显示出来.
                self.smallCircle.hidden = NO;
            }];
        }else{
            
            //播放一个动画,图标消失.
            UIImageView *imageV = [[UIImageView alloc] init];
            imageV.frame = self.bounds;
            [self addSubview:imageV];
            
            NSMutableArray *imageArray = [NSMutableArray array];
            
            //加载动画图片
            for (int i = 0; i < 8; i++) {
                NSString *imageName = [NSString stringWithFormat:@"%d",i + 1];
                UIImage *image = [UIImage imageNamed:imageName];
                [imageArray addObject:image];
            }
            
            //设置动画图片
            imageV.animationImages = imageArray;
            //设置动画执行时长
            imageV.animationDuration = 1;
            //开始动画
            [imageV startAnimating];
            
            //延迟多长时间执行,block当中的代码
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self removeFromSuperview];
                
            });
            
        }
    }
    
    
    
}



//求两个圆之间的距离
- (CGFloat)distanceWithSmallCircle:(UIView *)smallCircle bigCircle:(UIView *)bigCircle{
    
    //求X轴方向的偏移量
    CGFloat offsetX = bigCircle.center.x - smallCircle.center.x;
    //求Y轴方向的偏移量
    CGFloat offsetY = bigCircle.center.y - smallCircle.center.y;
    
    CGFloat distance = sqrtf(offsetX * offsetX + offsetY * offsetY);
    
    return distance;
}


- (UIBezierPath *)pathWithSmallCircle:(UIView *)smallCircle bigCircle:(UIView *)bigCircle{
    
    CGFloat x1 = smallCircle.center.x;
    CGFloat y1 = smallCircle.center.y;
    
    CGFloat x2 = bigCircle.center.x;
    CGFloat y2 = bigCircle.center.y;
    
    CGFloat d = [self distanceWithSmallCircle:smallCircle bigCircle:self];
    
    if (d <= 0) {
        return nil;
    }
    
    
    CGFloat cosθ = (y2 - y1) / d;
    CGFloat sinθ = (x2 - x1) / d;
    
    CGFloat r1 = smallCircle.bounds.size.width * 0.5;
    CGFloat r2 = bigCircle.bounds.size.width * 0.5;
    
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ, y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ, y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ, y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ, y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d * 0.5 * sinθ, pointA.y + d * 0.5 * cosθ);
    CGPoint pointP = CGPointMake(pointB.x + d * 0.5 * sinθ, pointB.y + d * 0.5 * cosθ);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //AB
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    //BC(曲线)
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    //CD
    [path addLineToPoint:pointD];
    //DA(曲线)
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
    
}




//取消高亮状态
-(void)setHighlighted:(BOOL)highlighted{
    
}




@end
