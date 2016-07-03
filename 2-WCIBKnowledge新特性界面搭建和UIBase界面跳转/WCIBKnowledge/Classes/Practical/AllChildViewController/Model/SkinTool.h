//
//  SkinTool.h
//  01-换肤(界面的搭建和基本实现)
//
//  Created by 袁武昌 on 16/7/3.
//  Copyright © 2016年 com.yuan900133. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkinTool : NSObject
+ (void)setSkinColor:(NSString *)skinColor;

+ (UIImage *)skinToolWithImageName:(NSString *)imageName;

+ (UIColor *)skinToolWithBgColor;

@end
