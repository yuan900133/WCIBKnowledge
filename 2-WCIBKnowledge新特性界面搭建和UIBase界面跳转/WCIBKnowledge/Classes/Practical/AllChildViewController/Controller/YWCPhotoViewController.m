
//
//  YWCPhotoViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/7/11.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCPhotoViewController.h"

#import "PhotoCell.h"

#import "FlowLayout.h"

@interface YWCPhotoViewController ()<UICollectionViewDataSource>

@end

@implementation YWCPhotoViewController

static NSString * const ID = @"cell";

/*
 UICollectionView使用步骤
 1.创建UICollectionView必须要初始化布局参数
 2.UICollectionViewCell必须注册,不能通过代码创建
 3.UICollectionViewCell默认没有一个子控件,想要展示东西,必须自定义cell
 */

/*
 问题:
 调整间距:
 
 示例效果,每个cell不一样大,
 目前效果所有cell都是一样大
 
 默认流水布局,每个cell都长一样, => 如果想要不一样,自定义布局
 
 给流水布局添加一些新功能,给系统的方法添加功能,重写方法,不需要覆盖系统实现
 
 */

#define YWCScreenW [UIScreen mainScreen].bounds.size.width
#define YWCScreenH [UIScreen mainScreen].bounds.size.height

/*
 高聚合(代码),低耦合(类与类之间关系)
 //    int a = 10;
 //    int b = 20;
 //    int c = a + b;
 
 // 类似逗号表达式,值等于最后一个分号的值.
 int c = ({
 int c;
 int a = 10;
 int b = 20;
 c = a + b;
 20;
 });
 
 NSLog(@"%d",c);
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    // 创建UICollectionView流水布局
    UICollectionViewFlowLayout *layout = ({
        // GCC
        UICollectionViewFlowLayout *layout = [[FlowLayout alloc] init];
        
        
        layout.itemSize = CGSizeMake(160, 160);
        // 行间距
        layout.minimumLineSpacing = 50;
        
        // 设置cell间距,不一定准确
        layout.minimumInteritemSpacing = 50;
        
        // 设置组间距
        layout.sectionInset = UIEdgeInsetsMake(0,(YWCScreenW - 160) * 0.5 , 0, (YWCScreenW - 160) * 0.5);
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        layout;
    });
    
    // 创建UICollectionView,UICollectionView默认为黑色
    UICollectionView *collectionView = ({
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 200);
        collectionView.center = self.view.center;
        collectionView.backgroundColor = [UIColor brownColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:collectionView];
        
        // 设置数据源
        collectionView.dataSource = self;
        
        collectionView;
    });
    
    // 注册PhotoCell
    [collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    
}

#pragma mark - UICollectionViewDataSource

// 返回cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

// 返回cell外观
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // forIndexPath:必须注册
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    
    cell.image = [UIImage imageNamed:imageName];
    
    return cell;
}


@end
