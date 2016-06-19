//
//  YWCApp.h
//  12-掌握-多图下载
//
//  Created by 袁武昌 on 16/6/4.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWCApp : NSObject
/*
 download = "9982\U4e07";
 icon = "http://p19.qhimg.com/dr/48_48_/t0101e2931181bb540d.png";
 name = "\U6355\U9c7c\U8fbe\U4eba2";
 */
/** 名称*/
@property(nonatomic ,strong) NSString *name;
/** 图标*/
@property(nonatomic ,strong) NSString *icon;
/** 下载量*/
@property(nonatomic ,strong) NSString *download;

+(instancetype)appWithDict:(NSDictionary *)dict;
@end
