//
//  YWCCar.h
//  08-索引条
//
//  Created by 袁武昌 on 16/5/2.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWCCar : NSObject
/**
 *  图标
 */
@property (nonatomic ,copy)NSString * icon;
/**
 *  名称
 */
@property (nonatomic ,copy)NSString * name;

+ (instancetype)carWithDict:(NSDictionary *)dict;
@end
