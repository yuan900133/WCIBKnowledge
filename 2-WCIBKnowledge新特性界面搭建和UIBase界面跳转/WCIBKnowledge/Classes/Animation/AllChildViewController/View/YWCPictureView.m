


//
//  YWCPictureView.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/14.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCPictureView.h"

@implementation YWCPictureView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    //只要绘制东西到UIView上面,都必须得要在drawRect方法当中进行.
    //画图片
    //加载图片
    UIImage *image =  [UIImage imageNamed:@"1"];
    //drawAtPoint绘制的图片的原始尺寸大小.
    [image drawAtPoint:CGPointZero];
    //把图片填充到rect区域当中.
    [image drawInRect:rect];
    
    //裁剪,超过裁剪区域以外的内容都会被裁剪掉.
    //注意:设置裁剪区域,一定要在显示(绘图)之前
    UIRectClip(CGRectMake(0, 0, 100, 100));
    //    //平铺
    [image drawAsPatternInRect:rect];
    //
    
    //快速的填充一个矩形
    UIRectFill(CGRectMake(50, 50, 100, 100));
    
    
    
    // Drawing code
    //只要绘制东西到UIView上面,都必须得要在drawRect方法当中进行.
    //只要绘制东西到UIView上面,都必须得要在drawRect方法当中进行.
    //画文字
    NSString *str = @"小五";
    //withAttributes:文字的属性.字体大小,颜色,阴影,描边.
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //文字的大小
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:50];
    //文字的颜色
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    //描边
    dict[NSStrokeWidthAttributeName] = @1;
    dict[NSStrokeColorAttributeName] = [UIColor blueColor];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    //设置阴影的偏移量
    shadow.shadowOffset = CGSizeMake(-10, -10);
    shadow.shadowColor = [UIColor greenColor];
    shadow.shadowBlurRadius = 2;
    
    //阴影
    dict[NSShadowAttributeName] = shadow;
    //drawAtPoint,指定绘制的点, 但是它不会自动换行.
    //    [str drawAtPoint:CGPointZero withAttributes:dict];
    //drawInRect:会自动换行.
    [str drawInRect:self.bounds withAttributes:dict];
    

}
@end
