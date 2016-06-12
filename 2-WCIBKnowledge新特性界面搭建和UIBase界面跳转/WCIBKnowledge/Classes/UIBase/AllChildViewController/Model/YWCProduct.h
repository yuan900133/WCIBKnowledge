//
//  YWCProduct.h
//  02-综合示例
//
//  Created by 袁武昌 on 16/5/1.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWCProduct : NSObject
@property(nonatomic,copy)NSString *icon;
@property(nonatomic, copy)NSString *name;

-(instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)productWithDict:(NSDictionary *)dict;

@end
