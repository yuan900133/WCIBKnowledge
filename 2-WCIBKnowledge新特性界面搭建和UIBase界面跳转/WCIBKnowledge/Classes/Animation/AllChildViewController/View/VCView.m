
//
//  VCView.m
//  07-手势解锁(搭建界面)
//
//  Created by 袁武昌 on 16/5/21.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "VCView.h"

@implementation VCView

-(void)drawRect:(CGRect)rect{
    
    UIImage *image = [UIImage imageNamed:@"Home_refresh_bg"];
    [image drawInRect:rect];
    
}


@end
