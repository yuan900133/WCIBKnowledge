
//
//  DrawView.m
//  01-基本线条绘制(画线)
//
//  Created by 袁武昌 on 16/5/19.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

//作用:专门进行绘图.
//什么时候调用:(系统帮我们调用还是需要手动调用?)是系统帮我们自动调用.当View显示的时候调用.
//参数rect:是当前View的Bounds
- (void)drawRect:(CGRect)rect {
    
    
    //        UIBezierPath *path = [UIBezierPath bezierPath];
    //        [path moveToPoint:CGPointMake(20, 250)];
    //        [path addLineToPoint:CGPointMake(250, 20)];
    //        [path stroke];
    
    
    //画圆角矩形
    //cornerRadius:圆角半径.
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 100, 100) cornerRadius:50];
    //    [path fill];
    
    //    //画椭圆
    //    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)];
    //    [[UIColor yellowColor] set];
    //    [path fill];
    
    //画弧
    //Center:圆心
    //radius:圆的半径
    //startAngle:开始角度
    //endAngle:结束角度.
    //clockwise:顺时针画弧,逆时针画弧,YES,顺时针,NO:逆时针
    //注意:圆心不能使用center, center它的坐是相对于它的父控件.
    CGPoint center =  CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5 - 10;
    UIBezierPath *path =  [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:-M_PI_2 clockwise:NO];
    //画扇形
    //添加一根到圆心.
    [path addLineToPoint:center];
    //关闭路径(从路径的终点连接到路径的起点.)
    //    [path closePath];
    //填充时,它会自动的关闭路径.
    [[UIColor redColor] set];
    [path fill];
    
    //1.获取图形上下文.->2.描述路径->3.把路径添加到上下文.->4.把上下文的内容渲染View.
    
}

//矩形
- (void)drawRect{
    
    //1.获取图形上下文.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.描述路径
    //矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 100, 100)];
    
    //3.把路径添加到上下文.
    CGContextAddPath(ctx, path.CGPath);
    
    [[UIColor redColor] setFill];
    //4.把上下文的内容渲染View.
    //    CGContextStrokePath(ctx);
    CGContextFillPath(ctx);
    
    
    
    
}


- (void)drawCurve{
    
    //画曲线
    //1.获取图形上下文.
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.描述路径
    //曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 250)];
    [path addQuadCurveToPoint:CGPointMake(250, 250) controlPoint:CGPointMake(50, 50)];
    //3.把路径添加到上下文.
    CGContextAddPath(ctx, path.CGPath);
    //4.把上下文当中的内容渲染到View.
    CGContextStrokePath(ctx);
    
}


- (void)drawLine{
    
    
    //1.获取图形上下文.()无论是获取上下文,还是创建上下文都是以 UIGraphics
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.绘制图形(描述路径)贝瑟尔路径.
    UIBezierPath *path = [UIBezierPath bezierPath];
    //2.1,设置路径的起点.
    [path moveToPoint:CGPointMake(20, 250)];
    //2.2,添加一根到路径的终点.
    [path addLineToPoint:CGPointMake(250, 20)];
    //一条路径可以描述多条线.
    //    [path moveToPoint:CGPointMake(20, 280)];
    //    [path addLineToPoint:CGPointMake(250, 50)];
    //把上条线的终点当作是下一条线起点.
    [path addLineToPoint:CGPointMake(150, 250)];
    
    
    //设置上下文的状态.
    CGContextSetLineWidth(ctx, 10);
    //设置线的连接样式.
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    //设置顶角样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //设置线的颜色setStroke,set
    [[UIColor redColor] set];
    
    
    //3.把路径保存到上下文.
    //UIKit:path ->   CoreGraphics:path
    CGContextAddPath(ctx, path.CGPath);
    //4.把上下文当中内容渲染到View. stroke(描边)  fill(填充)
    CGContextStrokePath(ctx);
    
}



@end
