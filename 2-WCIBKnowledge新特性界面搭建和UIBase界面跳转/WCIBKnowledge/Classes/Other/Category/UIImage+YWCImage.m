
//
//  UIImage+YWCImage.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/5.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "UIImage+YWCImage.h"

@implementation UIImage (YWCImage)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}


+ (UIImage *)imageWithBorderW:(CGFloat)borderW corlor:(UIColor *)color Image:(UIImage *)image
{
    //0.加载图片
    //1.先开启一个图片(上下文尺寸大小在原始图片基础上宽高都加上两倍边框宽度.)
    CGSize size = CGSizeMake(image.size.width + 2 * borderW, image.size.height + 2 * borderW);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //2.填充一个圆形路径.这个圆形路径大小,和上下文尺寸大小一样.
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    //设置边框颜色
    [color set];
    [path fill];
    //3.添加一个小圆,小圆,x,y从边框宽度位置开始添加,宽高和原始图片一样大小.把小圆设为裁剪区域.
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    //把小圆设为裁剪区域.
    [clipPath addClip];
    //4.把图片给绘制上去
    [image drawAtPoint:CGPointMake(borderW, borderW)];
    //5.生成一张新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文.
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
