//
//  PieView.m
//  04-绘制饼图
//
//  Created by 袁武昌 on 16/5/19.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "PieView.h"

@implementation PieView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    //画每个扇形
    
    NSArray *dataArray = @[@25,@25,@50];
    
    
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
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //重绘
    [self setNeedsDisplay];
    
}




- (void)drawPie{
    
    CGPoint center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat radius = self.bounds.size.width * 0.5 - 20;
    
    CGFloat startA = 0;
    CGFloat angle = 25 / 100.0 * M_PI * 2;
    CGFloat endA = startA + angle;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    //添加一根线到圆心
    [path addLineToPoint:center];
    [[UIColor redColor] set];
    [path fill];
    
    
    startA  =  endA;
    angle = 25 / 100.0 * M_PI * 2;
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
