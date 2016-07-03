
//
//  YWCApp.m
//  12-掌握-多图下载
//
//  Created by 袁武昌 on 16/6/4.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCApp.h"

@implementation YWCApp
+(instancetype)appWithDict:(NSDictionary *)dict
{
    YWCApp *app = [[YWCApp alloc]init];
    
    //KVC
    [app setValuesForKeysWithDictionary:dict];
    return app;
}
@end
