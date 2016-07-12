//
//  PhotoCell.m
//  01-UICollectionView基本使用
//
//  Created by 袁武昌 on 16/7/11.
//  Copyright © 2016年 com.yuan900133. All rights reserved.
//

#import "PhotoCell.h"
@interface PhotoCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation PhotoCell
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}
@end
