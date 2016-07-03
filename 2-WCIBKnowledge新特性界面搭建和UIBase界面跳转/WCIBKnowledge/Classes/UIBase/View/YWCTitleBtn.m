//
//  YWCTitleBtn.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/7/3.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCTitleBtn.h"

@implementation YWCTitleBtn

- (void)awakeFromNib
{
    // 设置边框宽度
    self.layer.borderWidth = 1.0;
    // 设置边框颜色
    self.layer.borderColor = YWCRandomColor.CGColor;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.backgroundColor = YWCRandomColor;
    // 设置圆角半径
    self.layer.cornerRadius = self.frame.size.height * 0.5;
    self.layer.masksToBounds = YES;
}

@end
