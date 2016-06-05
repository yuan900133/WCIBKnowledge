//
//  YWCUIBaseController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/4.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCUIBaseController.h"
#import "YWCUIBaseCell.h"
@interface YWCUIBaseController ()
@property(nonatomic,strong)NSArray *titleArr;
@end

@implementation YWCUIBaseController


- (NSArray *)titleArr
{
    if (_titleArr == nil) {
        _titleArr = @[@"拳皇",@"购物按钮",@"分页",@"车数据",@"索引条",@"点餐",@"百思段子",@"酒刷新",@"购物车",@"注册",@"通讯录",@"微博个人详情"];
    }
    return _titleArr;
}

static NSString * const UIBaseCellId = @"uiBase";

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
    flow.itemSize = CGSizeMake(160,180);
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
    
    self.collectionView.backgroundColor = YWCRandomColor;
    
    
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //UICollectionViewCell必须得要注册.
     [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YWCUIBaseCell class]) bundle:nil] forCellWithReuseIdentifier:UIBaseCellId];
    
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
    
    
    YWCUIBaseCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:UIBaseCellId forIndexPath:indexPath];
    
    
//    NSString *imageName = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    CGFloat arccount = self.titleArr.count;
    NSInteger count = arc4random_uniform(arccount);
    
    NSString *imageName = [NSString stringWithFormat:@"%ld",count +1];
    cell.backgroundColor = [UIColor clearColor];
    cell.title_Label = self.titleArr[indexPath.row];
//    cell.title_Label.textColor = YWCRandomColor;
//    cell.title_Label.backgroundColor = YWCRandomColor;
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self.titleArr[indexPath.row]);
}

@end
