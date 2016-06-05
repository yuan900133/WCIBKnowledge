
//
//  UIView+YWCFrame.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/5.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "UIView+YWCFrame.h"

@implementation UIView (YWCFrame)
- (void)setYwc_centerX:(CGFloat)ywc_centerX
{
    CGPoint center = self.center;
    center.x = ywc_centerX;
    self.center = center;
}

- (CGFloat)ywc_centerX
{
    return self.center.x;
    
}

- (void)setYwc_centerY:(CGFloat)ywc_centerY
{
    CGPoint center = self.center;
    center.x = ywc_centerY;
    self.center = center;
}
- (CGFloat)ywc_centerY
{
    return self.center.y;
    
}

- (CGFloat)width
{
    return self.bounds.size.width;
    
}
- (CGFloat)height
{
    return self.bounds.size.height;
    
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
}
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (CGFloat)y
{
    return self.frame.origin.y;
    
}
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
    
}
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

@end
