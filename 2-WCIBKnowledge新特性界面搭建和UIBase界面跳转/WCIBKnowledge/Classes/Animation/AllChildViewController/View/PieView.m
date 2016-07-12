//
//  PieView.m
//  04-绘制饼图
//
//  Created by 袁武昌 on 16/5/19.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "PieView.h"

@implementation PieView

- (void)awakeFromNib
{
    // 设置边框宽度
    self.layer.borderWidth = 5.0;
    // 设置边框颜色
    self.layer.borderColor = [UIColor grayColor].CGColor;
    
    // 设置圆角半径
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    self.layer.masksToBounds = YES;
    
    
    CABasicAnimation *animation = [[CABasicAnimation alloc]init];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI *2);
    animation.keyPath = @"transform.rotation.z";
    animation.duration = 30;
    animation.repeatCount = NSIntegerMax;
    animation.removedOnCompletion = NO;
    [self.layer addAnimation:animation forKey:@"rotation"];
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    //画每个扇形
    
    
    
    
    NSArray *dataArray = @[@10,@10,@10,@10,@10,@10,@10,@10,@10,@10];
    
    
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat radius = self.bounds.size.width * 0.5 - 20;
    
    CGFloat startA = 0;
    CGFloat angle = 0;
    CGFloat endA = 0;
    
    
    for (NSNumber *num in dataArray) {
        
        startA = endA;
        angle =  num.intValue / 100.0 * M_PI * 2;
        endA = startA + angle;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        //添加一根线到圆心
        [path addLineToPoint:center];
        [[self randomColor] set];
        [path fill];
    }
}

//随机生成一个颜色
- (UIColor *)randomColor{
    
    return YWCRandomColor;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //重绘
    [self setNeedsDisplay];
    
}




- (void)drawPie{
    
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat radius = self.bounds.size.width * 0.5 - 20;
    
    CGFloat startA = 0;
    CGFloat angle = 10 / 100.0 * M_PI * 2;
    CGFloat endA = startA + angle;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    //添加一根线到圆心
    [path addLineToPoint:center];
    [[UIColor redColor] set];
    [path fill];
    
    
    startA  =  endA;
    angle = 10 / 100.0 * M_PI * 2;
    endA = startA + angle;
    
    path =  [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    //添加一根线到圆心
    [path addLineToPoint:center];
    [[UIColor greenColor] set];
    [path fill];
    
    
    startA  =  endA;
    angle = 50 / 100.0 * M_PI * 2;
    endA = startA + angle;
    
    path =  [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    //添加一根线到圆心
    [path addLineToPoint:center];
    [[UIColor blueColor] set];
    [path fill];
    
}


@end
