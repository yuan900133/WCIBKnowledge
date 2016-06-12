//
//  YWCWineCell.h
//  04-数据刷新(全局刷新)
//
//  Created by 袁武昌 on 16/5/2.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YWCWine;
@interface YWCWineCell : UITableViewCell
@property(nonatomic,strong)YWCWine *wine;
/** 打钩控件*/
@property (nonatomic, weak)UIImageView *checkedImageView;
@end
