
//
//  YWCWatermarkController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/14.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCWatermarkController.h"

@interface YWCWatermarkController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIImageView *imageV1;
@end



@implementation YWCWatermarkController

- (void)cutScreen
{
    //截屏.
    //1.开启位图上下文.
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    //2.把控制器View的内容绘制到上下文当中.
    //layer是不能够直接画到上下文当中, 它要渲染到上下文当中.
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:ctx];
    //3.从上下文当中生成一张图片
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭上下文.
    UIGraphicsEndImageContext();
    
    //文件都以二进流的形式进行传输.
    NSData *data = UIImageJPEGRepresentation(newImage, 1);
    [data writeToFile:@"/Users/yuanwuchang/Desktop/yuan/test/newImage.jpg" atomically:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.加载图片.
    UIImage *image = [UIImage imageNamed:@"1"];
    //2.加载文字
    NSString *str = @"小wu";
    //3.开启一个位图上下文.
    //size:要开启多大的位图上下文.
    //opaque:不透明
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //4.把图片绘制到位图上下文.
    [image drawAtPoint:CGPointZero];
    //5.把文字绘制到位图上下文.
    
    NSMutableDictionary *dict = [NSMutableDictionary  dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:50];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    [str drawAtPoint:CGPointMake(image.size.width *0.5, image.size.height*0.5) withAttributes:dict];
    //6.从上下文当中生成一张新的图片.
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //7.要手动关闭位图上下文.
    UIGraphicsEndImageContext();
    
    self.imageV.image = newImage;
 
    
    
    //1.加载图片
    UIImage *image1 = [UIImage imageNamed:@"1"];
    //2.开启一个位图上下文.
    UIGraphicsBeginImageContextWithOptions(image1.size, NO, 0);
    //3.设置一个圆形的裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    //把路径设置成裁剪区域
    [path addClip];
    //4.把图片绘制到上下文当中.
    [image1 drawAtPoint:CGPointZero];
    //5.从上下文当中生成一张图片
    UIImage *newImage1 = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭位图上下文.
    UIGraphicsEndImageContext();
    
    self.imageV1.image = newImage1;
}
@end
