//
//  YWCWebViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/11.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCWebViewController.h"
#define ID @"cell"
#define YWCHeadH 200
#define YWCHeadMinH 64
#define YWCTabBarH 44
#import "UIImage+YWCImage.h"
@interface YWCWebViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 最开始y轴偏移量*/
@property (nonatomic ,assign) CGFloat oriOffsetY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCons;



@end

@implementation YWCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置tableView数据源
    self.tableView.dataSource = self;
    // 设置tableView代理
    self.tableView.delegate = self;
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    // 不需要调节额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 清空导航条
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    
    // 记录下最开始偏移量
    _oriOffsetY = -(YWCHeadH + YWCTabBarH);
    
    // 设置tableView顶部的额外滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake((YWCHeadH + YWCTabBarH), 0, 0, 0);
    // 设置下导航条文字
    UILabel *label = [[UILabel alloc] init];
    label.text = @"小五";
    [label sizeToFit];
    //    label.alpha = 0.1;
    label.textColor = [UIColor colorWithWhite:0 alpha:0];
    self.navigationItem.titleView = label;
    
    
}

// 偏移量:

// 监听tableView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 计算下tableView滚动距离
    CGFloat delta = offsetY - _oriOffsetY;
    
    // 修改头部视图y值
    //    self.topCons.constant = - delta;
    CGFloat height = (YWCHeadH - delta);
    if (height < YWCHeadMinH) {
        height = YWCHeadMinH;
    }
    // 视觉差效果
    self.heightCons.constant = height;
    
    
    // 处理导航条
    CGFloat alpha = delta  / (YWCHeadH - YWCHeadMinH);
    
    if (alpha >= 1) {
        alpha = 0.99;
    }
    
    // 确定颜色
    UIColor *whiteColor = [UIColor colorWithWhite:1 alpha:alpha];
    
    // 生成对应的图片
    UIImage *image = [UIImage imageWithColor:whiteColor];
    
    // 设置导航条透明度
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    // 设置标题文字颜色
    UILabel *label = (UILabel *)self.navigationItem.titleView;
    label.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    NSLog(@"%f",alpha);
    
}

// 展示tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
  
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}



@end
