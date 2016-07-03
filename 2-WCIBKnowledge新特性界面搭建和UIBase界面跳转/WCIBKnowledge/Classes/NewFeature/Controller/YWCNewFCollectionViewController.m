
//
//  YWCNewFCollectionViewController.m
//  zhaosuliaowang
//
//  Created by yuan on 16/3/12.
//  Copyright © 2016年 yuan. All rights reserved.
//

#import "YWCNewFCollectionViewController.h"
#import "YWCTabBarController.h"


//总页数
#define YWCPageCount 4
@interface YWCNewFCollectionViewController ()

/** 开始体验按钮*/
@property (nonatomic, weak)UIButton *startBtn;
/** 开始体验按钮*/
@property (nonatomic, weak)UIButton *jumpBtn;
/**pageControl*/
@property(nonatomic ,weak)UIPageControl *pageControl;

@end

@implementation YWCNewFCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

//pageControl的属性设置
- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        UIPageControl * pageControl= [[UIPageControl alloc] init];
        
        pageControl.numberOfPages = YWCPageCount;
        [pageControl setValue:[UIImage imageNamed:@"current_pageControl"] forKey:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"_pageControl"] forKey:@"_pageImage"];
        
        pageControl.bounds = CGRectMake(0, 0, 200, 200);
        //调整位置
        pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height *0.95);
        [self.view addSubview:pageControl];
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
        startBtn.bounds = CGRectMake(0, 0, 130, 40);
        //调整按钮按钮
        startBtn.center = CGPointMake(self.view.width * 0.5, self.view.height *0.795);
        [startBtn setTitle:@"立即体验" forState:UIControlStateNormal];
        [startBtn setTitleColor:YWCRandomColor forState:UIControlStateNormal];
        [startBtn setBackgroundColor:YWCRandomColor];
        
        //监听按钮的点击
        [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:startBtn];
        _startBtn = startBtn;
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
        [jumpBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        jumpBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        //设置按钮的尺寸
        jumpBtn.bounds = CGRectMake(0, 0, 40, 20);
        //调整按钮按钮
        jumpBtn.center = CGPointMake(self.view.width * 0.95, self.view.height *0.05);
        
        //监听按钮的点击
        [jumpBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        //把按钮添加到item上.
        [self.view addSubview:jumpBtn];
        _jumpBtn = jumpBtn;
        
    }
    return _jumpBtn;
}

//点击开始按钮进入程序的主框架
- (void)startBtnClick{
    
    
    YWCTabBarController *tabarVc = [[YWCTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabarVc;
    
}


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
    flow.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*0.33,[UIScreen mainScreen].bounds.size.width*0.33);
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
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.jumpBtn.hidden = NO;
}



//有多少组.
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return 1;
}

//第一组当中有多少Items(格子)
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 60  ;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //加载图片
    NSString *imageName = [NSString stringWithFormat:@"%d",arc4random_uniform(19) +1];
    UIImage *image = [UIImage imageNamed:imageName];
    
    // 设置边框宽度
    cell.layer.borderWidth = 5.0;
    // 设置边框颜色
    cell.layer.borderColor = YWCRandomColor.CGColor;
    
    // 设置圆角半径
    cell.layer.cornerRadius = cell.width * 0.5;
    cell.layer.masksToBounds = YES;
    //给Cell当中image进行赋值
    
    cell.backgroundView = [[UIImageView alloc]initWithImage:image];

   
    
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
        self.startBtn.hidden = NO;
        
    }else{
        self.pageControl.hidden = NO;
        self.pageControl.currentPage = page;
        self.startBtn.hidden = YES;
    }
        
}

@end












