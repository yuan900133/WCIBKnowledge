
//
//  Flag.m
//  08-注册界面(拦截用户输入)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "Flag.h"

@implementation Flag
+ (instancetype)flagWithDict:(NSDictionary *)dict
{
    Flag *flag = [[self alloc] init];
    
    // 字典转模型
    // 字典value是什么类型,给模型的属性就是什么类型
    [flag setValuesForKeysWithDictionary:dict];
    // setValuesForKeysWithDictionary:KVC字典转模型
    // 1.遍历字典里面所有key name,icon
    // 2.会去模型中查找,有没有对应的属性或者方法,如果有就属性赋值
    //    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
    //        // KVC
    //        // icon zhongguo.jpg
    //
    //        [flag setValue:value forKey:key];
    //
    //        NSLog(@"%@ %@",key,value);
    //    }];
    
    
    //    flag.icon = [UIImage imageNamed:flag.icon];
    
    //    NSLog(@"%@",[flag.icon class]);
    
    return flag;
}

- (void)setIcon:(NSString *)icon
{
    _icon = [UIImage imageNamed:icon];
}

/*
 [flag setValue:@"zhongguo.jpg" forKey:@"icon"]
 1.寻找有没有setIcon方法,有,就直接调用方法去赋值[flag setIcon:@"zhongguo.jpg"]
 2.寻找有没有icon属性,有,直接赋值 icon = icon;
 3.寻找有没有_icon属性,有,直接赋值 _icon = icon;
 4.找不到,直接报错setValue:forUndefinedKey:
 
 模型的属性名一定要跟字典的key一一对应
 */

@end
