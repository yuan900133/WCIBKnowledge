
//
//  FlagView.m
//  08-注册界面(拦截用户输入)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "FlagView.h"
#import "Flag.h"
@interface FlagView ()

@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end
@implementation FlagView
- (void)setFlag:(Flag *)flag
{
    _flag = flag;
    
    _nameView.text = flag.name;
    _iconView.image = flag.icon;
    //    [UIImage imageNamed:flag.icon];
}

+ (instancetype)flagView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"FlagView" owner:nil options:nil] firstObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
