//
//  ProgressView.m
//  03-下载进度条(重绘)
//
//  Created by 袁武昌 on 16/5/19.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

-(void)setProgressValue:(CGFloat)progressValue{
    _progressValue = progressValue;
    NSLog(@"22222222");
    //手动调用drawRect方法, 它并不会给我们生成跟View相关联上下文.
    //    [self drawRect:self.bounds];
    
    [self setNeedsDisplay];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSLog(@"22222222%s",__func__);
    CGPoint center =  CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5 - 10;
    
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 + self.progressValue * M_PI * 2;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    //描边路径
    [path stroke];
    
}


@end
