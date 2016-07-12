//
//  YWCCircleButton.m
//  01-购物车-圆角按钮处理
//
//  Created by 袁武昌 on 16/5/7.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCCircleButton.h"

@implementation YWCCircleButton
- (void)setHighlighted:(BOOL)highlighted
{
    
}
- (void)awakeFromNib
{
    // 设置边框宽度
    self.layer.borderWidth = 1.0;
    // 设置边框颜色
    self.layer.borderColor = [UIColor grayColor].CGColor;
    // 设置圆角半径
    self.layer.cornerRadius = self.frame.size.width * 0.5;
}

@end
