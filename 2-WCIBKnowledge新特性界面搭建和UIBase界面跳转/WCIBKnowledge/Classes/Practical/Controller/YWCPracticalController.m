//
//  YWCPracticalController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/4.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCPracticalController.h"
#import "YWCPracticalCell.h"
@interface YWCPracticalController ()
@property(nonatomic,strong)NSArray *titleArr;
@end

@implementation YWCPracticalController

static NSString * const PracticalCellId = @"practical";
- (NSArray *)titleArr
{
    if (_titleArr == nil) {
        _titleArr = @[@"QQ空间",@"美团",@"打开系统的应用程序",@"分享",@"第三方登录",@"通讯录",@"静态库",@"换肤",@"支付宝集成",@"APP测试发布",@"内购/广告",@"苹果支付",@"推送通知",@"传感器",@"UIDynamic",@"内存析",@"硬件信息获取",@"录音",@"音效播放",@"音乐播放",@"视频播放",@"CoreLocation定位",@"指南针",@"代理到Block转换",@"MapKit框架",@"系统导航",@"集成百度地图"];
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
    flow.itemSize = CGSizeMake(160 , 150);
    //设置每一行的最小间距
    flow.minimumLineSpacing = 20;
    //设置每个item之间的最小间距
    flow.minimumInteritemSpacing = 20;
    flow.sectionInset = UIEdgeInsetsMake(0,10 , 0, 10);
    
    //设置滚动的方向
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return [super initWithCollectionViewLayout:flow];
}


/**注册CollectionViewCell*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = YWCRandomColor;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //UICollectionViewCell必须得要注册.
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YWCPracticalCell class]) bundle:nil] forCellWithReuseIdentifier:PracticalCellId];
    
    //添加内部的子控件
    //    [self setUp];
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
    
    
    YWCPracticalCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:PracticalCellId forIndexPath:indexPath];
    
//    NSString *imageName = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    NSString *imageName = [NSString stringWithFormat:@"%d",arc4random_uniform(19) +1];
    cell.backgroundColor = [UIColor clearColor];
    cell.image = [UIImage imageNamed:imageName];
    cell.title_Label = self.titleArr[indexPath.row];
    
    return cell;
}
@end