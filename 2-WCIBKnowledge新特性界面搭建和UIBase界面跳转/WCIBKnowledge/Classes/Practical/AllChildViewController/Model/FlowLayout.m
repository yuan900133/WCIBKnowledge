//
//  FlowLayout.m
//  01-UICollectionView基本使用
//
//  Created by 袁武昌 on 16/7/11.
//  Copyright © 2016年 com.yuan900133. All rights reserved.
//

#import "FlowLayout.h"

/*
 自定义布局掌握5个方法
 1.- (void)prepareLayout;
 
 2.- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect;
 3. - (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;
 4.- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity;
 5. - (CGSize)collectionViewContentSize;
 */

@implementation FlowLayout

// 什么时候调用:collectionView开始布局的时候就会调用,collectionView只要一刷新也会调用
// 一定要记得调用[super prepareLayout]
// 作用:计算所有cell的布局,前提条件,cell的布局是固定
- (void)prepareLayout
{
    [super prepareLayout];
    
}

// UICollectionViewLayoutAttributes:描述cell布局
// 每一个cell对应UICollectionViewLayoutAttributes对象
// 设置cell的布局,就找对应的UICollectionViewLayoutAttributes对象

// 作用:指定一个rect,就返回这个区域内所有cell布局
// 可以一次性给定所有cell的布局,也可以分批
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //    NSLog(@"%@",NSStringFromCGRect(rect));
    // 1.获取显示cell的布局对象,当前显示区域确定
    // 2.cell离中心点越小,就越大,越远,就越小,比例跟离中心点距离有关系
    NSArray *arr = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    CGFloat offsetX = self.collectionView.contentOffset.x;
    CGFloat collectionW = self.collectionView.bounds.size.width;
    
    for (UICollectionViewLayoutAttributes *attr in arr) {
        
        // 计算下当前cell离中心点距离
        CGFloat delta = fabs(attr.center.x - (offsetX + collectionW * 0.5)) ;
        
        // 比例: 0 ~ 1 => 0 ~ 0.5 1 ~ 0.85
        CGFloat scale = 1 - delta / (collectionW * 0.5) * 0.15;
        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return arr;
}

// Invalidate:刷新
// 当滚动时候是否允许刷新布局(重写布局)
// 作用:每次滚动都需要重写布局,就返回yes.
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

// 什么时候调用:当用户手指离开的时候就会调用
// 作用:返回最后偏移量,决定collectionView最终停留位置
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 思路:手指离开之后,调整最终cell布局
    
    // 1.获取最终显示区域
    CGFloat offsetX = self.collectionView.contentOffset.x;
    CGFloat collectionW = self.collectionView.bounds.size.width;
    CGFloat collectionH = self.collectionView.bounds.size.height;
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, collectionW, collectionH);
    
    // 2.获取最终显示cell的布局
    NSArray *cellAttrs = [super layoutAttributesForElementsInRect:targetRect];
    
    // 3.判断下这些cell,哪个cell离中心点越近,让最近cell显示在中间
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in cellAttrs) {
        // 计算下离中心点距离
        CGFloat delta = attr.center.x - (offsetX + collectionW * 0.5);
        
        if (fabs(delta) < fabs(minDelta)) {
            minDelta = delta;
        }
    }
    
    // 计算出最小距离中心点距离
    proposedContentOffset.x += minDelta;
    
    if (proposedContentOffset.x <= 0) {
        proposedContentOffset.x = 0;
    }
    
    return proposedContentOffset;
}

@end
