

//
//  YWCTitleLabel.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/5.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCTitleLabel.h"

@implementation YWCTitleLabel
- (void)awakeFromNib
{
    // 设置边框宽度
    self.layer.borderWidth = 3.0;
    // 设置边框颜色
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor brownColor];
    // 设置圆角半径
    self.layer.cornerRadius = self.frame.size.height * 0.5;
    self.layer.masksToBounds = YES;
}
@end
