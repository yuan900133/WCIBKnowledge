
//
//  YWCNewFCollectionViewController.m
//  zhaosuliaowang
//
//  Created by yuan on 16/3/12.
//  Copyright © 2016年 yuan. All rights reserved.
//

#import "YWCNewFCollectionViewController.h"
#import "YWCNewFeatureCell.h"

//总页数
#define YWCPageCount 4
@interface YWCNewFCollectionViewController ()
/** 上次的偏移量 ScollView上一次的offsetX*/
@property (nonatomic ,assign) CGFloat preOffsetX;
/** guideImageV*/
@property (nonatomic, weak)UIImageView *guide;
/**pageControl*/
@property(nonatomic ,weak)UIPageControl *pageControl;

@end

@implementation YWCNewFCollectionViewController

static NSString * const reuseIdentifier = @"Cell";


/**状态栏样式*/
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
/**初始化*/
-(instancetype)init{
    
    //创建一个流水布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    //修改布局参数,来修改格子的样式.
    //设置每一个格子的尺寸大小.
    flow.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    //设置每一行的最小间距
    flow.minimumLineSpacing = 0;
    //设置每个item之间的最小间距
    flow.minimumInteritemSpacing = 0;
    //设置滚动的方向
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:flow];
}


/**注册CollectionViewCell*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置分页效果
    self.collectionView.pagingEnabled = YES;
    //取消水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = YWCRandomColor;
    //取消弹簧效果
    self.collectionView.bounces = NO;
    
    //UICollectionViewCell必须得要注册.
    [self.collectionView registerClass:[YWCNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //添加内部的子控件
//    [self setUp];
}
/**添加pageControl*/
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    YWCNewFeatureCell * pageControlCell = [[YWCNewFeatureCell alloc] init];
    
    self.pageControl = pageControlCell.pageControl;
    self.pageControl.center=
    CGPointMake(self.view.width * 0.5, self.view.height *0.95);
    
    [self.view addSubview:self.pageControl];
    
}


//有多少组.
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return 1;
}

//第一组当中有多少Items(格子)
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YWCNewFeatureCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //加载图片
    NSString *imageName = [NSString stringWithFormat:@"%d",arc4random_uniform(19) +1];
    UIImage *image = [UIImage imageNamed:imageName];
    
//    // 设置边框宽度
//    cell.layer.borderWidth = 5.0;
//    // 设置边框颜色
//    cell.layer.borderColor = YWCRandomColor.CGColor;
//    
//    // 设置圆角半径
//    cell.layer.cornerRadius = cell.width * 0.5;
//    cell.layer.masksToBounds = YES;
    //给Cell当中image进行赋值
    cell.image = image;
    

    //添加立即体验按钮
    [cell setStartBtn:indexPath count:YWCPageCount];
    
    return cell;
    
}
//开始滚动时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算当前滚动的页面
     int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);

    
    //最后一页
    if (page == YWCPageCount-1) {
        self.pageControl.hidden = YES;
        
    }else{
        self.pageControl.hidden = NO;
        self.pageControl.currentPage = page;
    }
        
}

@end












