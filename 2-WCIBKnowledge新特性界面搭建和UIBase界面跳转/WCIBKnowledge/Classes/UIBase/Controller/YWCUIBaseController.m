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
    
     [self setupAllChildVc];
    
    //    初始化collectionView
    [self setUp];
    
   
    
}
- (void)setupAllChildVc
{
    [self addChildViewController:[[YWCGameController alloc] init]];
    [self addChildViewController:[[YWCShopViewController alloc] init]];
    [self addChildViewController:[[YWCWineViewController alloc] init]];
    [self addChildViewController:[[YWCCarViewController alloc] init]];
    [self addChildViewController:[[YWCRefreshViewController alloc] init]];
    [self addChildViewController:[[YWCShopWineController alloc] init]];
    
    
}

- (void)setUp
{
    self.collectionView.backgroundColor = YWCRandomColor;
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

    
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   

    if (indexPath.row == 6) {
        YWCRegisterController *Register = [[YWCRegisterController alloc] init];
        [self.navigationController pushViewController:Register animated:YES];
        
    }else if (indexPath.row == 7) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([LoginViewController class]) bundle:nil];
        LoginViewController *login = [storyboard instantiateInitialViewController];
        
        
        [self.navigationController pushViewController:login animated:YES];
        
    }else if (indexPath.row == 8) {
        YWCWebViewController *web = [[YWCWebViewController alloc] init];
        [self.navigationController pushViewController:web animated:YES];
        
    }else{
    
        [self.navigationController pushViewController:self.childViewControllers[indexPath.row] animated:YES];
    }
    
    
    
    
}

@end
