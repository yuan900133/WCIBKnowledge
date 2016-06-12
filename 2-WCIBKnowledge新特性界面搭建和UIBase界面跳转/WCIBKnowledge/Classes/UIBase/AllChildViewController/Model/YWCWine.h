//
//  YWCWine.h
//  04-展示单组数据
//
//  Created by 袁武昌 on 16/5/2.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWCWine : NSObject
/** 图标*/
@property (nonatomic ,copy)NSString *image;

/** 价格*/
@property (nonatomic ,copy)NSString *money;

/** 名称*/
@property (nonatomic ,copy)NSString *name;
/**
 *  记录这行对应的cell是否被打钩
 */
@property (nonatomic ,assign ,getter=isChecked)BOOL checked;

/** 用户购买的酒的数量*/
@property (nonatomic ,assign)int count;

+ (instancetype)wineWithDict:(NSDictionary *)dict;
@end
