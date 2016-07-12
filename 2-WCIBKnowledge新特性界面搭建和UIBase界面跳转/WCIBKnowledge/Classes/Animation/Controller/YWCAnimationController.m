//
//  YWCAnimationController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/5.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCAnimationController.h"
#import "YWCDrawViewController.h"
#import "YWCDragSubController.h"
#import "YWCDrawBoardController.h"
#import "YWCProgressController.h"
#import "YWCCookieController.h"
#import "YWCPictureController.h"
#import "YWCSnowViewController.h"
#import "YWCWatermarkController.h"
#import "YWCwipeViewController.h"
#import "YWCCutScreenController.h"
#import "YWCLockViewController.h"
#import "YWCDrawBoardController.h"
#import "YWCClockViewController.h"
#import "YWCHeartController.h"
#import "YWCWheelViewController.h"
#import "YWCFoldViewController.h"
#import "YWCShadowController.h"
#import "YWCQQViewController.h"

#import "YWCAnimationCell.h"

@interface YWCAnimationController ()
@property(nonatomic,strong)NSArray *titleArr;

/***定时器*/
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation YWCAnimationController

static NSString * const AnimationCellId = @"animation";

- (NSArray *)titleArr
{
    if (_titleArr == nil) {
        _titleArr = @[@"抽屉效果",@"划线画形状",@"下载进度",@"画饼",@"画图",@"雪花",@"图片水印,裁减,截屏",@"擦除",@"图片截屏",@"手势解锁",@"画板",@"时钟",@"心跳,图片抖动",@"转盘",@"图片折叠,音量震动条",@"倒影,粒子效果",@"QQ粘性布局"];
    }
    return _titleArr;
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
    flow.itemSize = CGSizeMake(YWCScreenW , YWCScreenW);
    //设置每一行的最小间距
    flow.minimumLineSpacing = 0;
    //设置每个item之间的最小间距
    flow.minimumInteritemSpacing = 0;
    flow.sectionInset = UIEdgeInsetsMake(0,0 , 0, 0);
    //设置滚动的方向
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return [super initWithCollectionViewLayout:flow];
}


/**注册CollectionViewCell*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //添加内部的子控件
        [self setUp];
}

//view将要显示
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addTimer];
}
//View将要消失
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeTimer];
    
}
#pragma mark **********************添加定时器*****************************
/**启动时钟*/
-(void) addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer ;
    
}
/**删除定时器*/
-(void) removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark - *******************UIScrollView代理*************************
/**将要开始拖拽*/
-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
/**当用户停止拖拽的时候调用*/

-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
    
}
/**设置页码*/
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
//    int page = (int)(scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.pageImageArr.count;
//    self.pageControl.currentPage =page;
}

/**滚到下一页*/
static NSInteger nextItem = 0;
-(void) nextpage{
    nextItem++;
    if (nextItem == self.titleArr.count) {
        nextItem=0;
        
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}





- (void)setUp{
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //UICollectionViewCell必须得要注册.
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YWCAnimationCell class]) bundle:nil] forCellWithReuseIdentifier:AnimationCellId];
}






//有多少组.
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return 1;
}

//第一组当中有多少Items(格子)
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YWCAnimationCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:AnimationCellId forIndexPath:indexPath];
    
//    NSString *imageName = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    NSString *imageName = [NSString stringWithFormat:@"%d",arc4random_uniform(19) +1];
    cell.backgroundColor = [UIColor clearColor];
    cell.image = [UIImage imageNamed:imageName];
    cell.title_Label = self.titleArr[indexPath.row];
    // 设置圆角半径
    cell.layer.cornerRadius = cell
    .bounds.size.width * 0.5;
    cell.layer.masksToBounds = YES;
    
    // 如果想要做一些牛逼的动画, 可以在这个位置来做
    
    
    CABasicAnimation *animation = [[CABasicAnimation alloc]init];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI *2);
    animation.keyPath = @"transform.rotation.z";
    animation.duration = 30;
    animation.repeatCount = NSIntegerMax;
    animation.removedOnCompletion = NO;
    [cell.layer addAnimation:animation forKey:@"rotation"];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 0) {
        YWCDragSubController *dragSub = [[YWCDragSubController alloc]init];
        [self.navigationController pushViewController:dragSub animated:YES];
    }else  if (indexPath.row == 1) {
        YWCDrawViewController *draw = [[YWCDrawViewController alloc]init];
        [self.navigationController pushViewController:draw animated:YES];
    }else  if (indexPath.row == 2) {
        YWCProgressController *progress = [[YWCProgressController alloc]init];
        [self.navigationController pushViewController:progress animated:YES];
    }else  if (indexPath.row == 3) {
        YWCCookieController *cookie = [[YWCCookieController alloc]init];
        [self.navigationController pushViewController:cookie animated:YES];
    }else  if (indexPath.row == 4) {
        YWCPictureController *picture = [[YWCPictureController alloc]init];
        [self.navigationController pushViewController:picture animated:YES];
    }else  if (indexPath.row == 5) {
        YWCSnowViewController *snow = [[YWCSnowViewController alloc]init];
        [self.navigationController pushViewController:snow animated:YES];
        
    }else  if (indexPath.row == 6) {
        YWCWatermarkController *waterMark = [[YWCWatermarkController alloc]init];
        [self.navigationController pushViewController:waterMark animated:YES];
    }else if (indexPath.row == 7) {
        YWCwipeViewController *wipe = [[YWCwipeViewController alloc]init];
        [self.navigationController pushViewController:wipe animated:YES];
    }else if (indexPath.row == 8) {
        YWCCutScreenController *cutScreen = [[YWCCutScreenController alloc]init];
        [self.navigationController pushViewController:cutScreen animated:YES];
    }else if (indexPath.row == 9) {
        YWCLockViewController *lock = [[YWCLockViewController alloc]init];
        [self.navigationController pushViewController:lock animated:YES];
    }else if (indexPath.row == 10) {
        YWCDrawBoardController *drawBoard = [[YWCDrawBoardController alloc]init];
        [self.navigationController pushViewController:drawBoard animated:YES];
    }else if (indexPath.row == 11) {
        YWCClockViewController *clock = [[YWCClockViewController alloc]init];
        [self.navigationController pushViewController:clock animated:YES];
    }else if (indexPath.row == 12) {
        YWCHeartController *heart = [[YWCHeartController alloc]init];
        [self.navigationController pushViewController:heart animated:YES];
    }else if (indexPath.row == 13) {
        YWCWheelViewController *wheel = [[YWCWheelViewController alloc]init];
        [self.navigationController pushViewController:wheel animated:YES];
    }else if (indexPath.row == 14) {
        YWCFoldViewController *fold = [[YWCFoldViewController alloc]init];
        [self.navigationController pushViewController:fold animated:YES];
    }else if (indexPath.row == 15) {
        YWCShadowController *shadow = [[YWCShadowController alloc]init];
        [self.navigationController pushViewController:shadow animated:YES];
    }else if (indexPath.row == 16) {
        YWCQQViewController *qq = [[YWCQQViewController alloc]init];
        [self.navigationController pushViewController:qq animated:YES];
    }
}
@end