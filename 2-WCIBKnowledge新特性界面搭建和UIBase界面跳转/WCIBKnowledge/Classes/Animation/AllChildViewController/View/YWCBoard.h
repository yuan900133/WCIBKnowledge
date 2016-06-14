//
//  YWCBoard.h
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/14.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWCBoard : UIView
//清屏
- (void)clear;
//撤销
- (void)undo;
//橡皮擦
- (void)erase;
//选择线宽
- (void)setLineWidth:(CGFloat)width;
//选择颜色
- (void)setLineColor:(UIColor *)color;
/** 要绘制图片*/
@property(nonatomic ,strong) UIImage *image;


@end
