//
//  YWCProductView.m
//  02-综合示例
//
//  Created by 袁武昌 on 16/5/1.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCProductView.h"
#import "YWCProduct.h"
/*
 1.在initWithFrame方法中,初始化子控件
 2.给子控件添加两个成员变量的弱引用
 3.在layoutSubViews中,调整子控件的frame
 4.给子控件设置数据
 1>将子控件直接暴露出去
 2>对外提供接口,通过接口给子控件设置数据
 3>对外提供模型对象的接口,之后给子控件设置数据
 */
@interface YWCProductView()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation YWCProductView
+ (instancetype)productView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"YWCProductView" owner:nil options:nil] firstObject];
}



- (void)setProduct:(YWCProduct *)product
{
    _product = product;
    self.iconImage.image = [UIImage imageNamed:product.icon];
    self.titleLabel.text = product.name;
}

@end
