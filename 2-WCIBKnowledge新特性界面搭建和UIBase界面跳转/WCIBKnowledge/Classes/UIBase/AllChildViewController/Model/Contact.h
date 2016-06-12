//
//  Contact.h
//  05-私人通讯录(搭建登录界面)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;

+ (instancetype)contactWithName:(NSString *)name phone:(NSString *)phone;
@end
