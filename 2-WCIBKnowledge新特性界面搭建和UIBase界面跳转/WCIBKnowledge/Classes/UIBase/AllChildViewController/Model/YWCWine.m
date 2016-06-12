//
//  YWCWine.m
//  04-展示单组数据
//
//  Created by 袁武昌 on 16/5/2.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCWine.h"

@implementation YWCWine
+ (instancetype)wineWithDict:(NSDictionary *)dict
{
    YWCWine *wine = [[self alloc] init];
    [wine setValuesForKeysWithDictionary:dict];
    return wine;
}
@end
