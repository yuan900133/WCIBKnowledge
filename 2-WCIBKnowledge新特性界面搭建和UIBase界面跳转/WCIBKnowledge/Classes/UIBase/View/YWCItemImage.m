//
//  YWCItemImage.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/5.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCItemImage.h"

@implementation YWCItemImage

- (void)awakeFromNib
{
    // 设置边框宽度
    self.layer.borderWidth = 5.0;
    // 设置边框颜色
    self.layer.borderColor = [UIColor grayColor].CGColor;
    
    // 设置圆角半径
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    self.layer.masksToBounds = YES;
}

@end
