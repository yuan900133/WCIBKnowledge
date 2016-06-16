//
//  WheelView.h
//  14-转盘(界面搭建)
//
//  Created by 袁武昌 on 16/5/22.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WheelView : UIView
+ (instancetype)wheelView;


//开始旋转
- (void)start;
//暂停旋转
- (void)stop;

@end
