
//
//  YWCCar.m
//  08-索引条
//
//  Created by 袁武昌 on 16/5/2.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCCar.h"

@implementation YWCCar
+ (instancetype)carWithDict:(NSDictionary *)dict {
    
    YWCCar *car = [[self alloc] init];
    [car setValuesForKeysWithDictionary:dict];
    return car;
}
@end
