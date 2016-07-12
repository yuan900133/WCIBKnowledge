
//
//  YWCShopWineController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/11.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCShopWineController.h"
#import "YWCWine.h"
#import "YWCShopWineCell.h"
#import "MJExtension.h"
@interface YWCShopWineController ()
<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
/** 酒数据*/
@property(nonatomic ,strong)NSArray *wineArray;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@end

@implementation YWCShopWineController
static NSString *shopWineId = @"shopWine";
- (NSArray *)wineArray
{
    if (!_wineArray) {
        _wineArray = [YWCWine objectArrayWithFilename:@"wine.plist"];
        for (YWCWine *wine in _wineArray) {
            [wine addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        }
        
    }
    return _wineArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YWCShopWineCell class]) bundle:nil] forCellReuseIdentifier:shopWineId];
    
}
// 移除通知
- (void)dealloc
{
    for (YWCWine *wine in _wineArray) {
        [wine removeObserver:self forKeyPath:@"count"];
    }
}
#pragma mark - 监听通知
#pragma mark - KVO的监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(YWCWine *)wine change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    // NSKeyValueChangeNewKey == @"new"
    int new = [change[NSKeyValueChangeNewKey] intValue];
    // NSKeyValueChangeOldKey == @"old"
    int old = [change[NSKeyValueChangeOldKey] intValue];
    
    if (new > old) { // 增加数量
        // 计算总价
        int totalPrice = self.totalPriceLabel.text.intValue + wine.money.intValue;
        // 设置总价
        self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
        
        // 购买按钮能点击
        self.buyButton.enabled = YES;
        
    } else { // 减小数量
        int totalPrice = self.totalPriceLabel.text.intValue - wine.money.intValue;
        // 设置总价
        self.totalPriceLabel.text = [NSString stringWithFormat:@"%d",totalPrice];
        // 决定购买是否能点击
        self.buyButton.enabled = (totalPrice > 0);
    }
}
- (IBAction)buy {
    
    // 打印用户购买的商品
    for (YWCWine *wine in self.wineArray) {
        if (wine.count > 0) {
            NSLog(@"购买了%d件%@",wine.count,wine.name);
        }
    }
    
}
- (IBAction)clear {
    self.totalPriceLabel.text = @"0";
    
    // 修改模型
    for (YWCWine *wine in self.wineArray) {
        wine.count = 0;
    }
    
    // 刷新表格
    [self.tableView reloadData];
    
    // 购买按钮不能点击
    self.buyButton.enabled = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.wineArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YWCShopWineCell *cell = [tableView dequeueReusableCellWithIdentifier:shopWineId];
    cell.wine = self.wineArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
@end
