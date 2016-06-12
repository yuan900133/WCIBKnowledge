
//
//  Contact.m
//  05-私人通讯录(搭建登录界面)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "Contact.h"

@implementation Contact
+ (instancetype)contactWithName:(NSString *)name phone:(NSString *)phone
{
    Contact *c = [[self alloc] init];
    
    c.name = name;
    c.phone = phone;
    
    return c;
}
@end
