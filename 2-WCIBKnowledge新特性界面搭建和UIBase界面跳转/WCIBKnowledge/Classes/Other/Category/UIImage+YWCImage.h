//
//  UIImage+YWCImage.h
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/5.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YWCImage)
// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

//带边框的图片裁减
+ (UIImage *)imageWithBorderW:(CGFloat)borderW corlor:(UIColor *)color Image:(UIImage *)image;
@end
