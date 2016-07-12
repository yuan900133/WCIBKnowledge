
//
//  YWCNewFeatureCell.m
//  zhaosuliaowang
//
//  Created by yuan on 16/3/12.
//  Copyright © 2016年 yuan. All rights reserved.
//

#import "YWCNewFeatureCell.h"
#import "YWCTabBarController.h"
//总页数
#define YWCPageCount 4

@interface YWCNewFeatureCell()

/** UIImageView*/
@property (nonatomic, weak) UIImageView *imageV;
/** 开始体验按钮*/
@property (nonatomic, weak)UIButton *startBtn;
/** 开始体验按钮*/
@property (nonatomic, weak)UIButton *jumpBtn;



@end
@implementation YWCNewFeatureCell

//pageControl的属性设置
- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        UIPageControl * pageControl= [[UIPageControl alloc] init];
        
        pageControl.numberOfPages = YWCPageCount;
        pageControl.pageIndicatorTintColor = [UIColor    colorWithWhite:1.0 alpha:0.7];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        
        pageControl.bounds = CGRectMake(0, 0, 200, 200);
        //调整位置
        pageControl.center = CGPointMake(self.width * 0.5, self.height *0.95);
        
        _pageControl = pageControl;
        
    }
    return _pageControl;
}

//设置立即体验按钮属性
- (UIButton *)startBtn
{
    if (_startBtn == nil) {
        //        添加按钮
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //设置按钮的尺寸
        startBtn.bounds = CGRectMake(0, 0, 200, 80);
        //调整按钮按钮
        startBtn.center = CGPointMake(self.width * 0.5, self.height *0.795);
        [startBtn setTitle:@"立即体验" forState:UIControlStateNormal];
        [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       startBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _startBtn = startBtn;
        //监听按钮的点击
        [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        //把按钮添加到item上.
        [self.contentView addSubview:startBtn];
        
    }
    return _startBtn;
}
//设置开始按钮属性
- (UIButton *)jumpBtn
{
    if (_jumpBtn == nil) {
        //        添加按钮
        UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [jumpBtn setTitle:@"跳过" forState: UIControlStateNormal];
        [jumpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        jumpBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        
        //设置按钮的尺寸
        jumpBtn.bounds = CGRectMake(0, 0, 40, 20);
        //调整按钮按钮
        jumpBtn.center = CGPointMake(self.width * 0.95, self.height *0.05);
        _jumpBtn = jumpBtn;
        //监听按钮的点击
        [jumpBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        //把按钮添加到item上.
        [self.contentView addSubview:jumpBtn];
        
    }
    return _jumpBtn;
}

//点击开始按钮进入程序的主框架
- (void)startBtnClick{
    
    
    YWCTabBarController *tabarVc = [[YWCTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabarVc;
    
}

//collectionview的背景图片
-(UIImageView *)imageV{
    
    if (_imageV == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = self.bounds;
        [self.contentView addSubview:imageV];
        _imageV = imageV;
    }
    return _imageV;
}


-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageV.image = image;
}
/**添加立即体验按钮 方法*/
- (void)setStartBtn:(NSIndexPath *)indexPath count:(NSInteger)count
{
    
    //跳过按钮判断如果是第一个item
    if (indexPath.item == 0) {
        self.jumpBtn.hidden = YES;
    }else{
        self.jumpBtn.hidden = NO;
    }
    
    //立即体验按钮,判断如果是最后个item
    if (indexPath.item == count - 1) {
        //添加一个立即体验按钮,(点击之后,进入程序的主框架)
        //显示.
        self.startBtn.hidden = NO;
        self.pageControl.hidden = YES;
    }else{
        //隐藏.
        self.startBtn.hidden = YES;
        self.pageControl.hidden = NO;
    }
}
@end
