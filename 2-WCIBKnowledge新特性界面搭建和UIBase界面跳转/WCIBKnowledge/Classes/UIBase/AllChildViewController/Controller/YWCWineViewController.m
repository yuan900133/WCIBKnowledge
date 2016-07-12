//
//  YWCWineViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/9.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCWineViewController.h"
#import "YWCWine.h"
@interface YWCWineViewController ()
@property(nonatomic,strong)NSArray *WineArray;
@end

@implementation YWCWineViewController

- (NSArray *)WineArray
{
    if ( _WineArray == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wine" ofType:@"plist"]];
        NSMutableArray *wineArray = [NSMutableArray array];
        for (NSDictionary *wineDict in dictArray) {
            [wineArray addObject:[YWCWine wineWithDict:wineDict]];
        }
        _WineArray = wineArray;
    }
    return _WineArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 120;
    self.tableView.sectionHeaderHeight = 30;
    //    self.tableView.sectionFooterHeight = 80;
    self.tableView.separatorColor = [UIColor redColor];
    // 设置分割线的样式
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.tableView.tableHeaderView = [[UISwitch alloc] init];
    //    self.tableView.tableFooterView = [[UISwitch alloc] init];
    self.tableView.delegate = self;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.WineArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    YWCWine *wine = self.WineArray[indexPath.row];
    cell.textLabel.text = wine.name;
     cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%@",wine.image]];
   
   
    
    
   
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@",wine.money];
    cell.detailTextLabel.textColor = [UIColor orangeColor];
    
    // 如果想要做一些牛逼的动画, 可以在这个位置来做
    [cell.layer removeAnimationForKey:@"rotation"];
    CAKeyframeAnimation *animatioan = [[CAKeyframeAnimation alloc]init];
    animatioan.keyPath = @"transform.rotation.y";
    animatioan.values = @[@(-1),@(0),@(1),@(0)];
    animatioan.duration = 0.5;
    [cell.layer addAnimation:animatioan forKey:@"rotation"];
    
    //    cell.backgroundColor = [UIColor grayColor];
    return cell;
    // 设置cell的背景控件
    // backgroundViewy优先级 > backgroundColor
    //    UIView *bg = [[UIView alloc] init];
    //    bg.backgroundColor = [UIColor blueColor];
    //    cell.backgroundView = bg;
    // 设置cell选中时候的背景view
    //    UIView *selectedBg = [[UIView alloc] init];
    //    selectedBg.backgroundColor = [UIColor purpleColor];
    //    cell.selectedBackgroundView = selectedBg;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"头部";
}
#pragma mark - UITableViewDelegate
/**
 *  当用户选中(点击)了cell就会调用
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%zd",indexPath.row);
}
/**
 *  当用户取消选中(点击)了cell就会调用
 */
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"取消选中了:%zd",indexPath.row);
}



/**
 *  返回每一组的头部控件
 */
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    return [UIButton buttonWithType:UIButtonTypeContactAdd];
//}

/**
 *  返回每一组的尾部控件
 */
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return [UIButton buttonWithType:UIButtonTypeContactAdd];
//}

/**
 *  返回每一组的头部高度
 */
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 100;
//}
//
///**
// *  返回每一组的尾部高度
// */
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 100;
//}

/**
 *  返回每一行cell的高度
 */
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row % 2 == 0) {
//        return 80;
//    } else {
//        return 50;
//    }
//}
@end
