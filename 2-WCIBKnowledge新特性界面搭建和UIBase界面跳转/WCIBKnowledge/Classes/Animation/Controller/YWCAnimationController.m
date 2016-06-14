//
//  YWCAnimationController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/5.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCAnimationController.h"
#import "YWCDragSubController.h"
#import "YWCDrawViewController.h"
#import "YWCProgressController.h"
#import "YWCCookieController.h"
#import "YWCPictureController.h"
#import "YWCSnowViewController.h"


#import "YWCAnimationCell.h"

@interface YWCAnimationController ()
@property(nonatomic,strong)NSArray *titleArr;
@end

@implementation YWCAnimationController

static NSString * const AnimationCellId = @"animation";

- (NSArray *)titleArr
{
    if (_titleArr == nil) {
        _titleArr = @[@"抽屉效果",@"划线画形状",@"下载进度",@"画饼",@"画图",@"雪花",@"图片水印",@"裁减",@"截屏",@"擦除",@"图片截屏",@"手势解锁",@"画板",@"时钟",@"心跳",@"图片抖动",@"转盘",@"图片折叠",@"音量震动条",@"倒影",@"粒子效果",@"QQ粘性布局"];
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
    flow.itemSize = CGSizeMake(170 , 150);
    //设置每一行的最小间距
    flow.minimumLineSpacing = 5;
    //设置每个item之间的最小间距
    flow.minimumInteritemSpacing = 5;
    flow.sectionInset = UIEdgeInsetsMake(0,10 , 0, 10);
    //设置滚动的方向
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return [super initWithCollectionViewLayout:flow];
}


/**注册CollectionViewCell*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupAllChildVc];
    
    //添加内部的子控件
        [self setUp];
}
- (void)setUp{
    self.collectionView.backgroundColor = YWCRandomColor;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //UICollectionViewCell必须得要注册.
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YWCAnimationCell class]) bundle:nil] forCellWithReuseIdentifier:AnimationCellId];
}


- (void)setupAllChildVc
{
    [self addChildViewController:[[YWCDragSubController alloc]init]];
    [self addChildViewController:[[YWCDrawViewController alloc]init]];
    [self addChildViewController:[[YWCProgressController alloc]init]];
    [self addChildViewController:[[YWCCookieController alloc]init]];
    [self addChildViewController:[[YWCPictureController alloc]init]];
    [self addChildViewController:[[YWCSnowViewController alloc]init]];
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
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:self.childViewControllers[indexPath.row] animated:YES];
}
@end