//
//  YWCNetWorkCell.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/5.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCNetWorkCell.h"
@interface YWCNetWorkCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
@implementation YWCNetWorkCell

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

- (void)setTitle_Label:(NSString *)title_Label
{
    _title_Label = title_Label;
    _titleLabel.text = title_Label;
    
}
@end
