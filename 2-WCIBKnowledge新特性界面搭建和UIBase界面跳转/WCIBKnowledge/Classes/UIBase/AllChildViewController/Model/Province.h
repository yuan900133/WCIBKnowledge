//
//  Province.h
//  08-注册界面(拦截用户输入)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject
@property(nonatomic ,strong) NSArray *cities;
@property(nonatomic ,strong) NSString *name;

+ (instancetype)provinceWithDict:(NSDictionary *)dict;
@end
