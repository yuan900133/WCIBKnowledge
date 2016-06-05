//
//  YWCSaveTool.m
//  zhaosuliaowang
//
//  Created by yuan on 16/3/12.
//  Copyright © 2016年 yuan. All rights reserved.
//
#import "YWCSaveTool.h"

@implementation YWCSaveTool


+ (id)objectForKey:(NSString *)defaultName{
    
   return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}


+ (void)setObject:(id)value forKey:(NSString *)defaultName{
    
    //保存当前的版本号.
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    //并不是立马保存,它是在某一时刻系统统一进行保存.
    [defaults setObject:value forKey:defaultName];
    //立马进行保存.
    [defaults synchronize];
    
}


@end
