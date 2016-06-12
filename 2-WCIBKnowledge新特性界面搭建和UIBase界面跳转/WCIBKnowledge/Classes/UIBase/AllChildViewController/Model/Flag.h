//
//  Flag.h
//  08-注册界面(拦截用户输入)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Flag : NSObject
/* 目前一般开发,都是使用strong*/

/** name*/
@property (nonatomic ,strong) NSString *name;

/** icon字符串*/
@property (nonatomic ,strong) UIImage *icon;


+ (instancetype)flagWithDict:(NSDictionary *)dict;
@end
