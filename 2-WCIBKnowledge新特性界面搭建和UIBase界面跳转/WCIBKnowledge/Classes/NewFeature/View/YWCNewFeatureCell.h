//
//  YWCNewFeatureCell.h
//  zhaosuliaowang
//
//  Created by yuan on 16/3/12.
//  Copyright © 2016年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWCNewFeatureCell : UICollectionViewCell
@property(nonatomic ,strong) UIImage *image;

/**分页pageControl*/
@property (nonatomic ,weak)UIPageControl *pageControl;
/**添加立即体验按钮 方法*/
- (void)setStartBtn:(NSIndexPath *)indexPath count:(NSInteger)count;

@end
