
//
//  YWCVideo.m
//  04-掌握-复杂JSON的解析
//
//  Created by 袁武昌 on 16/6/19.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCVideo.h"

@implementation YWCVideo
+(instancetype)videoWithDict:(NSDictionary *)dict
{
    YWCVideo *video = [[YWCVideo alloc]init];
    //KVC
    [video setValuesForKeysWithDictionary:dict];
    
    return video;
}
@end
