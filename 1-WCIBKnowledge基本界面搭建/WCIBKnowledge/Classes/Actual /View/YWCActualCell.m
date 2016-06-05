
//
//  YWCActualCell.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/5.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCActualCell.h"
@interface YWCActualCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
@implementation YWCActualCell

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

@end
