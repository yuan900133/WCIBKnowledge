
//
//  Province.m
//  08-注册界面(拦截用户输入)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "Province.h"

@implementation Province
+ (instancetype)provinceWithDict:(NSDictionary *)dict
{
    Province *p = [[self alloc] init];
    
    [p setValuesForKeysWithDictionary:dict];
    
    return p;
}
@end
