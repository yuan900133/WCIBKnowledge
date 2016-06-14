
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
@end



@implementation YWCWatermarkController

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
    
    [str drawAtPoint:CGPointMake(50, 0) withAttributes:dict];
    //6.从上下文当中生成一张新的图片.
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //7.要手动关闭位图上下文.
    UIGraphicsEndImageContext();
    
    self.imageV.image = newImage;
    
}
@end
