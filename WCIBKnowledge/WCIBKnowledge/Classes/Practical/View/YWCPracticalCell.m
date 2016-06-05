//
//  YWCPracticalCell.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/5.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCPracticalCell.h"
@interface YWCPracticalCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation YWCPracticalCell

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

@end
