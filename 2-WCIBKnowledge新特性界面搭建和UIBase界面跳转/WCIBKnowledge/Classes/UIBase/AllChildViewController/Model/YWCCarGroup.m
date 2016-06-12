//
//  YWCCarGroup.m
//  08-索引条
//
//  Created by 袁武昌 on 16/5/2.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCCarGroup.h"
#import "YWCCar.h"
@implementation YWCCarGroup
+ (instancetype)carGroupWithDict:(NSDictionary *)dict
{
    YWCCarGroup *carGroup = [[self alloc] init];
    carGroup.title = dict[@"title"];
    
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *carDict in dict[@"cars"]) {
        [temp addObject:[YWCCar carWithDict:carDict]];
    }
    
    carGroup.cars = temp;
    
    return carGroup;
}
@end
