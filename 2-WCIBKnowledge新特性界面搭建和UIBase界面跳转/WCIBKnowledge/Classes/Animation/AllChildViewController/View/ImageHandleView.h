//
//  ImageHandleView.h
//  11-画板(界面搭建)
//
//  Created by 袁武昌 on 16/5/21.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ImageHandleView;
@protocol ImageHandleViewDelegate <NSObject>

- (void)imageHandleView:(ImageHandleView *)handleView newImage:(UIImage *)image;

@end



@interface ImageHandleView : UIView

@property(nonatomic ,strong) UIImage *image;

/** <#注释#>*/
@property (nonatomic, weak) id<ImageHandleViewDelegate> delegate;




@end
