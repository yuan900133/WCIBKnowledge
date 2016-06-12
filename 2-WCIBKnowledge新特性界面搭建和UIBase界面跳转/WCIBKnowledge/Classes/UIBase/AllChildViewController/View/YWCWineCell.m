//
//  YWCWineCell.m
//  04-数据刷新(全局刷新)
//
//  Created by 袁武昌 on 16/5/2.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCWineCell.h"
#import "YWCWine.h"
@implementation YWCWineCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *checkedImageView = [[UIImageView alloc] init];
        checkedImageView.image = [UIImage imageNamed:@"check"];
        checkedImageView.hidden = YES;
        [self.contentView addSubview:checkedImageView];
        self.checkedImageView = checkedImageView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat WH = 24;
    CGFloat X = self.contentView.frame.size.width - WH - 10;
    CGFloat Y = (self.contentView.frame.size.height - WH) * 0.5;
    self.checkedImageView.frame = CGRectMake(X, Y, WH, WH);
    
    CGRect frame = self.textLabel.frame;
    frame.size.width = self.contentView.frame.size.width  - self.textLabel.frame.origin.x - 20 - WH;
    self.textLabel.frame = frame;
}

- (void)setWine:(YWCWine *)wine
{
    _wine = wine;
    self.textLabel.text = wine.name;
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%@",wine.image]];
    self.detailTextLabel.text = [NSString stringWithFormat:@"¥%@",wine.money];
    //    if (wine.isChecked) {
    //        self.checkedImageView.hidden = NO;
    //    } else {
    //        self.checkedImageView.hidden = YES;
    //    }
    // 根据模型的checked属性决定打钩控件是否显示
    self.checkedImageView.hidden = !wine.isChecked;
    
}
@end
