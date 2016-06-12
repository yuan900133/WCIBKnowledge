//
//  YWCProduct.m
//  02-综合示例
//
//  Created by 袁武昌 on 16/5/1.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCProduct.h"

@implementation YWCProduct
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.icon = dict[@"icon"];
        self.name = dict[@"title"];
    }
    return self;
}

+ (instancetype)productWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
    
}
@end
