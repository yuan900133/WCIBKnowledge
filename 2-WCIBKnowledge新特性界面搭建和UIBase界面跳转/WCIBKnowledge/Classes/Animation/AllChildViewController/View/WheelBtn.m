//
//  WheelBtn.m
//  14-转盘(界面搭建)
//
//  Created by 袁武昌 on 16/5/22.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "WheelBtn.h"

@implementation WheelBtn
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * 0.5);
    
    if (CGRectContainsPoint(rect, point)) {
        return [super hitTest:point withEvent:event];
    }else{
        return nil;
    }
}

//取消按钮高亮状态下做的事.
-(void)setHighlighted:(BOOL)highlighted{
    
}
//返回按钮当中UIImageView的尺寸位置.
//ContentRect:当前按钮的尺寸位置 .
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = contentRect.size.width - 30;
    CGFloat imageH = 47;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 20;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
