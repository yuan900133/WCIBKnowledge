//
//  SkinTool.m
//  01-换肤(界面的搭建和基本实现)
//
//  Created by 袁武昌 on 16/7/3.
//  Copyright © 2016年 com.yuan900133. All rights reserved.
//

#import "SkinTool.h"

//@interface SkinTool ()
//
//// 实例对象的属性
//@property (nonatomic, copy) NSString *skinColor;
//
//@end

@implementation SkinTool

static NSString *_skinColor;

+ (void)initialize
{
    _skinColor = [[NSUserDefaults standardUserDefaults] objectForKey:@"skinColor"];
    
    if (_skinColor == nil) {
        _skinColor = @"green";
    }
}

+ (void)setSkinColor:(NSString *)skinColor
{
    _skinColor = skinColor;
    
    // 记录用户选中的皮肤
    [[NSUserDefaults standardUserDefaults] setObject:skinColor forKey:@"skinColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (UIImage *)skinToolWithImageName:(NSString *)imageName
{
    NSString *imageFileName = [NSString stringWithFormat:@"skin/%@/%@", _skinColor, imageName];
    
    return [UIImage imageNamed:imageFileName];
}
+ (UIColor *)skinToolWithBgColor
{
    // 1.获取bgColor.plist文件的路径
    NSString *bgColorName = [NSString stringWithFormat:@"skin/%@/bgColor.plist", _skinColor];
    NSString *bgColorPath = [[NSBundle mainBundle] pathForResource:bgColorName ofType:nil];
    
    // 2.读取plist文件
    NSDictionary *bgColorDict = [NSDictionary dictionaryWithContentsOfFile:bgColorPath];
    NSString *bgColorString = bgColorDict[@"labelBgColor"];
    
    // 3.截取bgColorString:0,0,255
    NSArray *bgColorArray = [bgColorString componentsSeparatedByString:@","];
    NSInteger red = [bgColorArray[0] integerValue];
    NSInteger green = [bgColorArray[1] integerValue];
    NSInteger blue = [bgColorArray[2] integerValue];
    
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
}

@end
