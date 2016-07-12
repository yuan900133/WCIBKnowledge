//
//  YWCUIBaseController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/4.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCUIBaseController.h"
#import "YWCGameController.h"
#import "YWCShopViewController.h"
#import "YWCWineViewController.h"
#import "YWCCarViewController.h"
#import "YWCRefreshViewController.h"
#import "YWCShopWineController.h"
#import "YWCRegisterController.h"
#import "LoginViewController.h"
#import "YWCWebViewController.h"

#import "YWCUIBaseCell.h"
@interface YWCUIBaseController ()
@property(nonatomic,strong)NSArray *titleArr;
@end

@implementation YWCUIBaseController




static NSString * const UIBaseCellId = @"uiBase";
- (NSArray *)titleArr
{
    if (_titleArr == nil) {
        _titleArr = @[@"拳皇",@"购物按钮",@"酒数据",@"索引条",@"酒刷新",@"购物车",@"注册",@"通讯录",@"微博个人详情"];
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
    flow.itemSize = CGSizeMake(YWCScreenW,YWCScreenW);
    //设置每一行的最小间距
    flow.minimumLineSpacing = 0;
    //设置每个item之间的最小间距
    flow.minimumInteritemSpacing = 0;
//    flow.sectionInset = UIEdgeInsetsMake(0,0 , 0, 0);
    

    //设置滚动的方向
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:flow];
}


/**注册CollectionViewCell*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    //    初始化collectionView
    [self setUp];
    
   
    
}


- (void)setUp
{
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //UICollectionViewCell必须得要注册.
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YWCUIBaseCell class]) bundle:nil] forCellWithReuseIdentifier:UIBaseCellId];
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
    
    
    
    
    
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        YWCGameController *game = [[YWCGameController alloc] init];
        [self.navigationController pushViewController:game animated:YES];
        
    }else if (indexPath.row == 1) {
        YWCShopViewController *shop = [[YWCShopViewController alloc] init];
        [self.navigationController pushViewController:shop animated:YES];
        
    }else if (indexPath.row == 2) {
        YWCWineViewController *wine = [[YWCWineViewController alloc] init];
        [self.navigationController pushViewController:wine animated:YES];
        
    }else if (indexPath.row == 3) {
        YWCCarViewController *car = [[YWCCarViewController alloc] init];
        [self.navigationController pushViewController:car animated:YES];
        
    }else if (indexPath.row == 4) {
        YWCRefreshViewController *refresh = [[YWCRefreshViewController alloc] init];
        [self.navigationController pushViewController:refresh animated:YES];
        
    }else if (indexPath.row == 5) {
        YWCShopWineController *shopWine = [[YWCShopWineController alloc] init];
        [self.navigationController pushViewController:shopWine animated:YES];
        
    }else if (indexPath.row == 6) {
        YWCRegisterController *Register = [[YWCRegisterController alloc] init];
        [self.navigationController pushViewController:Register animated:YES];
        
    }else if (indexPath.row == 7) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([LoginViewController class]) bundle:nil];
        LoginViewController *login = [storyboard instantiateInitialViewController];
        
        
        [self.navigationController pushViewController:login animated:YES];
        
    }else if (indexPath.row == 8) {
        YWCWebViewController *web = [[YWCWebViewController alloc] init];
        [self.navigationController pushViewController:web animated:YES];
        
    }
    
    
    
    
}

@end
