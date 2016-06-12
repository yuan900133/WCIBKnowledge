//
//  YWCProductView.h
//  02-综合示例
//
//  Created by 袁武昌 on 16/5/1.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YWCProduct;
@interface YWCProductView : UIView
+ (instancetype)productView;
// 设计思想三:对象提供模型对象,在自定义控件中拿到模型对象,之后将它的数据设置给自己的子控件
@property(nonatomic, strong)YWCProduct*product;
@end
