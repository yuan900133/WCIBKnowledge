//
//  YWCNewsViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/7/11.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCNewsViewController.h"


static CGFloat const titleScrollViewH = 44;
static CGFloat const btnW = 100;
static CGFloat const titleScale = 1.3;
#define YWCScreenW [UIScreen mainScreen].bounds.size.width
#define YWCScreenH [UIScreen mainScreen].bounds.size.height


@interface YWCNewsViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
// 记录上一个选中按钮
@property (nonatomic, weak) UIButton *selectButton;

/** 所有按钮的数组 */
@property(nonatomic ,strong) NSMutableArray<UIButton *> *titleBtns;

/** 判断下是否初始化过标题*/
@property (nonatomic ,assign) BOOL isInitial;

@end

@implementation YWCNewsViewController
// 先搭建界面 -> 处理这个界面一些业务逻辑(事件处理,点击事件,滚动事件等等)
#pragma mark - 懒加载
- (NSMutableArray<UIButton *> *)titleBtns
{
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

#pragma mark - 控制器的view生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    

    [self setupAllChildViewController];
    
    // 1.添加标题滚动视图
    [self setupTitleScrollView];
    
    // 2.添加内容滚动视图
    [self setupContentScrollView];
    
    // 5.监听标题按钮点击,
    // 1.标题颜色变成红色
    // 2.把对应控制器的view添加到对应位置
    // 3.让内容滚动view滚到对应位置
    
    // 取消自动添加额外滚动区域
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 6.滚动完成的时候做事情
    
}

// 3.添加所有的子控制器
- (void)setupAllChildViewController
{
    
    // 热点
    UIViewController *hotVc = [[UIViewController alloc] init];
    hotVc.title = @"热点";
    [self addChildViewController:hotVc];
    
    // 头条
    UIViewController *topLineVc = [[UIViewController alloc] init];
    topLineVc.title = @"头条";


    topLineVc.view.backgroundColor = YWCRandomColor;


    [self addChildViewController:topLineVc];
    
    // 视频
    UIViewController *videoVc = [[UIViewController alloc] init];
    videoVc.title = @"视频";


    videoVc.view.backgroundColor = YWCRandomColor;


    [self addChildViewController:videoVc];
    
    // 社会
    UIViewController *societyVc = [[UIViewController alloc] init];
    societyVc.title = @"社会";


    societyVc.view.backgroundColor = YWCRandomColor;


    [self addChildViewController:societyVc];
    
    // 订阅
    UIViewController *readerVc = [[UIViewController alloc] init];
    readerVc.title = @"订阅";


    readerVc.view.backgroundColor = YWCRandomColor;


    [self addChildViewController:readerVc];
    
    // 科技
    UIViewController *scienceVc = [[UIViewController alloc] init];
    scienceVc.title = @"科技";


    scienceVc.view.backgroundColor = YWCRandomColor;


    [self addChildViewController:scienceVc];
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_isInitial) {
        // 4.添加所有标题
        [self setupAllTitleButton];
        
        _isInitial = YES;
    }
    
}

// 1.添加标题滚动视图
- (void)setupTitleScrollView
{
    // 1.创建标题滚动视图
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    CGFloat titleScrollViewX = 0;
//    CGFloat titleScrollViewY = self.navigationController?navBarH:0;
    CGFloat titleScrollViewY = 0;
    CGFloat titleScrollViewW = YWCScreenW;
    // 1.1 设置frame
    titleScrollView.frame = CGRectMake(titleScrollViewX, titleScrollViewY, titleScrollViewW, titleScrollViewH);
    // 1.2 添加到view上
    [self.view addSubview:titleScrollView];
    
    _titleScrollView = titleScrollView;
    
}

// 2.添加内容滚动视图
- (void)setupContentScrollView
{
    // 1.创建标题滚动视图
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    CGFloat contentScrollViewX = 0;
    CGFloat contentScrollViewY = CGRectGetMaxY(self.titleScrollView.frame);
    CGFloat contentScrollViewW = YWCScreenW;
    CGFloat contentScrollViewH = YWCScreenH - contentScrollViewY;
    // 1.1 设置frame
    contentScrollView.frame = CGRectMake(contentScrollViewX, contentScrollViewY, contentScrollViewW, contentScrollViewH);
    // 1.2 添加到view上
    [self.view addSubview:contentScrollView];
    // 1.3 设置内容滚动view的代理
    contentScrollView.delegate = self;
    
    _contentScrollView = contentScrollView;
}


// 4.添加所有标题
- (void)setupAllTitleButton
{
    // 4.1 获取子控制器的总数
    NSInteger count = self.childViewControllers.count;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnH = titleScrollViewH;
    
    // 4.2 遍历所有子控制器,添加标题
    for (int i = 0; i < count; i++) {
        // 4.3 创建标题按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = i;
        [self.titleScrollView addSubview:btn];
        
        // 4.4 设置标题内容
        UIViewController *vc = self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 4.5监听按钮点击
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchDown];
        
        // 4.6 默认选中第0个按钮
        if (i == 0) {
            [self titleClick:btn];
        }
        
        // 保存到对应数组
        [self.titleBtns addObject:btn];
    }
    
    /*
     问题:
     1.titleScrollView不能滚动
     2.标题颜色默认为黑色
     3.隐藏titleScrollView水平指示器
     */
    
    // 4.7 设置标题滚动条滚动范围
    CGFloat contentW = count * btnW;
    self.titleScrollView.contentSize = CGSizeMake(contentW, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    // 4.8 设置内容滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count * YWCScreenW, 0);
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.bounces = NO;
}

// 5.标题按钮点击就会调用
- (void)titleClick:(UIButton *)button
{
    // 0.获取角标
    NSInteger i = button.tag;
    
    // 1.让标题按钮选中
    [self selectTitleButton:button];
    
    // 2.把对应控制器的view添加到对应位置
    [self setupChildViewController:i];
    
    // 3.让内容滚动view滚到对应位置
    CGFloat x = i * YWCScreenW;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
    /*
     问题:1.但是内容滚动view不能滚动
     2.隐藏水平指示器
     3.内容滚动view(UIScrollView)里面所有子控件,都往下偏移64
     4.开启分页,取消弹簧效果
     5.默认选中第0个
     
     iOS7下,导航控制器下scrollView顶部都会添加额外滚动区域64
     */
    
}

// 5.1 选中按钮
- (void)selectTitleButton:(UIButton *)btn
{
    // 恢复上一个按钮颜色
    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 恢复上一个形变
    _selectButton.transform = CGAffineTransformIdentity;
    
    // 设置当前选中按钮的颜色
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    // 设置标题缩放
    btn.transform = CGAffineTransformMakeScale(titleScale, titleScale);
    
    // 记录当前选中的按钮
    _selectButton = btn;
    
    // 让标题居中
    [self setupTitleCenter:btn];
    
    
    
}

// 5.2 添加子控制器view
- (void)setupChildViewController:(NSInteger)i
{
    // 取出对应子控制器
    UIViewController *vc = self.childViewControllers[i];
    if (vc.view.superview) return;
    
    CGFloat x = i * YWCScreenW;
    CGFloat y = 0;
    CGFloat w = YWCScreenW;
    CGFloat h = self.contentScrollView.bounds.size.height;
    vc.view.frame = CGRectMake(x, y, w, h);
    [self.contentScrollView addSubview:vc.view];
    
}

// 5.3 让标题居中
- (void)setupTitleCenter:(UIButton *)btn
{
    // 怎么让标题居中,移动偏移量
    CGFloat offsetX = btn.center.x - YWCScreenW * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - YWCScreenW;
    // 判断下是否大于最大滚动范围
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    // 设置偏移量
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    NSLog(@"%f",offsetX);
    
}

// 6.滚动完成的时候做事情
#pragma mark - UIScrollViewDelegate
// 滚动完成的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 0.当前偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 1.当前页码
    NSInteger i = offsetX / YWCScreenW;
    
    // 2.获取选中的按钮
    UIButton *btn = self.titleBtns[i];
    
    // 3.选中对应标题按钮
    [self selectTitleButton:btn];
    
    // 4.把对应的子控制器的view添加上去,显示出来
    [self setupChildViewController:i];
    
    
    
}

// 只要滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger count = self.titleBtns.count;
    // 缩放标题
    // 1.确定哪两个按钮缩放
    NSInteger leftI = scrollView.contentOffset.x / YWCScreenW;
    NSInteger rightI = leftI + 1;
    
    // 1.获取左边按钮
    UIButton *leftBtn = self.titleBtns[leftI];
    // 0 ~ 5
    
    // 2.获取右边按钮
    UIButton *rightBtn;
    // 6 6
    if (rightI < count) {
        rightBtn  = self.titleBtns[rightI];
    }
    
    // 3.形变按钮
    // 3.1 计算缩放比例
    CGFloat scaleR = scrollView.contentOffset.x / YWCScreenW - leftI;
    
    CGFloat scaleL = 1 - scaleR;
    
    // 0 ~ 1 1 ~ 1.3
    CGFloat transformScale = titleScale - 1;
    leftBtn.transform = CGAffineTransformMakeScale(scaleL * transformScale + 1, scaleL * transformScale + 1);
    rightBtn.transform = CGAffineTransformMakeScale(scaleR * transformScale + 1, scaleR * transformScale + 1);
    
    // 4.标题颜色渐变
    // 4.1获取右边按钮颜色
    UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    [leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
    [rightBtn setTitleColor:rightColor forState:UIControlStateNormal];
}

/*
 颜色:由RGB
 R G B
 黑色: 0 0 0
 红色: 1 0 0
 白色: 1 1 1
 */

@end
