//
//  YWCNetWorkController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/4.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCNetWorkController.h"
#import "YWCNetWorkCell.h"
@interface YWCNetWorkController ()
@property(nonatomic,strong)NSArray *titleArr;
@end

@implementation YWCNetWorkController

static NSString * const NetWorkCellId = @"netWork";

- (NSArray *)titleArr
{
    if (_titleArr == nil) {
        _titleArr = @[@"Pthread",@"NSThread线程通信",@"GCD线程间通信",@"单例模式通用",@"NSOperation线程间通信",@"多图下载",@"多图下载SD",@"GCD中的定时器",@"NSURLConnection发送GET请求",@"NSURLConnection发送POST请求",@"登录页面",@"JSON的解析",@"解析XML",@"文件下载",@"断点下载",@"输出流",@"文件上传",@"获得MIMEType",@"文件压缩和解压缩",@"NSURLSession的发送请求",@"NSURLSession下载文件",@"AFN",@"网络状态监测",@"MD5",@"https请求",@"UIWebView",@"OC和JS代码的交互"];
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
    //修改布局参数,来修改格子的样式.
    //设置每一个格子的尺寸大小.
    flow.itemSize = CGSizeMake(155 , 155);
    //设置每一行的最小间距
    flow.minimumLineSpacing = 10;
    //设置每个item之间的最小间距
    flow.minimumInteritemSpacing = 10;
    flow.sectionInset = UIEdgeInsetsMake(0,20 , 0, 20);
    
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
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YWCNetWorkCell class]) bundle:nil] forCellWithReuseIdentifier:NetWorkCellId];
    
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
    
    
    YWCNetWorkCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:NetWorkCellId forIndexPath:indexPath];
    
//    NSString *imageName = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    NSString *imageName = [NSString stringWithFormat:@"%d",arc4random_uniform(19) +1];
    cell.backgroundColor = [UIColor clearColor];
    
    
    cell.image = [UIImage imageNamed:imageName];
    cell.title_Label = self.titleArr[indexPath.row];
    
    return cell;
}
@end