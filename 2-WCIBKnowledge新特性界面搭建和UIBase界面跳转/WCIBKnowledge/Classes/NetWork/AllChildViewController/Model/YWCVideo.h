//
//  YWCVideo.h
//  04-掌握-复杂JSON的解析
//
//  Created by 袁武昌 on 16/6/19.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWCVideo : NSObject
/*
 id = 16;
 image = "resources/images/minion_16.png";
 length = 40;
 name = "\U5c0f\U9ec4\U4eba \U7b2c16\U90e8";
 url = "resources/videos/minion_16.mp4"
 */

@property(nonatomic ,strong) NSString  *id;
/** 图片的url*/
@property(nonatomic ,strong) NSString  *image;
/** 播放时间*/
@property(nonatomic ,strong) NSString  *length;
/** 视频的名称*/
@property(nonatomic ,strong) NSString  *name;
/** 视频的url*/
@property(nonatomic ,strong) NSString  *url;

+(instancetype)videoWithDict:(NSDictionary *)dict;
@end
