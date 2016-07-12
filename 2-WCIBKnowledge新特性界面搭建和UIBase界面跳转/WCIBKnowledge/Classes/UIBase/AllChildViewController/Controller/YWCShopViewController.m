//
//  YWCShopViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/9.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCShopViewController.h"

#import "YWCProduct.h"
#import "YWCProductView.h"
@interface YWCShopViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addProductBtn;
@property (weak, nonatomic) IBOutlet UIButton *remoceProductBtn;
@property (weak, nonatomic) IBOutlet UIView *productsView;

@property (nonatomic,assign)NSInteger index;

@property (nonatomic, strong)NSArray *products;


@property (weak, nonatomic) IBOutlet UILabel *hubView;

@end

@implementation YWCShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.productsView.backgroundColor = [UIColor clearColor];
}
- (IBAction)addProduct {
    // 1.1.定义一些常亮
    // 1.2.计算一些常亮
    CGFloat width = 70;
    CGFloat height = 100;
    NSInteger cols = 3;
    NSInteger rows = 2;
    NSInteger index = self.productsView.subviews.count;
    CGFloat hMargin = (self.productsView.frame.size.width - cols *width) / (cols - 1);
    CGFloat vMargin = (self.productsView.frame.size.height - rows *height) / (rows - 1);
    CGFloat x = self.index % 3*(width + hMargin);
    CGFloat y = self.index / 3* (height + vMargin);
    
    /*********************** 2.添加商品的View ***********************/
    // 2.1.创建普通UIView
    YWCProductView *productView = [YWCProductView productView];
    productView.backgroundColor = [UIColor clearColor];
    productView.frame = CGRectMake(x,y, width, height);
    [self.productsView addSubview:productView];
    // 2.3.添加UIImageView,用于显示商品的图标
    
    productView.product = self.products[index];
    self.index ++;
    self.addProductBtn.enabled = self.productsView.subviews.count != 6;
    
    self.remoceProductBtn.enabled = YES;
    // 5.当子控件的个数达到6个的时候,显示的提示
    if (self.productsView.subviews.count == 6) {
        // 显示指示器
        [self showHubView:@"购物车已满,不要再买买买!"];
    }
    
}
- (IBAction)removeProduct {
    [[self.productsView.subviews lastObject] removeFromSuperview];
    
    self.remoceProductBtn.enabled = self.productsView.subviews.count != 0;
    
    self.addProductBtn.enabled = YES;
    self.index--;
    // 4.当子控件的个数达到0个的时候,显示的提示
    if (self.productsView.subviews.count == 0) {
        // 显示指示器
        [self showHubView:@"购物车已空,赶紧买买买!"];
    }
    
}

- (void)showHubView:(NSString *)message
{
    self.hubView.text = message;
    self.hubView.textColor = [UIColor grayColor];
    [UIView animateWithDuration:0.25 animations:^{
        self.hubView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            self.hubView.alpha = 0.0;
        }];
    }];
}


- (NSArray *)products
{
    if (_products == nil) {
        
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"products.plist" ofType:nil];
        
        _products = [NSArray arrayWithContentsOfFile:filePath];
        // 3.将字典对象转成模型对象
        NSMutableArray *temArray = [NSMutableArray array];
        for (NSDictionary *dict in _products) {
            YWCProduct *product = [YWCProduct productWithDict:dict];
            [temArray addObject:product];
        }
        _products = temArray;
    }
    return _products;
}


@end
