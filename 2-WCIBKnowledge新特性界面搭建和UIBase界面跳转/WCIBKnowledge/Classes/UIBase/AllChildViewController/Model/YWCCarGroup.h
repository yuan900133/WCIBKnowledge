//
//  YWCCarGroup.h
//  08-索引条
//
//  Created by 袁武昌 on 16/5/2.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWCCarGroup : NSObject
/**
 *  这一组所有的车型(XMGCar)
 */
@property(nonatomic ,strong)NSArray *cars;
/**
 *  这一组的头部标题
 */
@property (nonatomic ,copy)NSString * title;

+ (instancetype)carGroupWithDict:(NSDictionary *)dict;
@end
