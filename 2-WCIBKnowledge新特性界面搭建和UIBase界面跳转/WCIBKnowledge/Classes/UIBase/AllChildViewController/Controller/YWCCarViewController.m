

//
//  YWCCarViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/9.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCCarViewController.h"

#import "YWCCar.h"
#import "YWCCarGroup.h"
@interface YWCCarViewController ()
@property(nonatomic,strong)NSArray *carGroups;
@end

@implementation YWCCarViewController

- (NSArray *)carGroups
{
    if (_carGroups == nil) {
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cars.plist" ofType:nil]];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            [temp addObject:[YWCCarGroup carGroupWithDict:dict]];
            
        }
        _carGroups = temp;
    }
    return _carGroups;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionIndexColor = [UIColor redColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor yellowColor];
}

// 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.carGroups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YWCCarGroup *group = self.carGroups[section];
    return group.cars.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*ID = @"car";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    YWCCarGroup *group = self.carGroups[indexPath.section];
    YWCCar *car = group.cars[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = car.name;
    cell.imageView.image = [UIImage imageNamed:car.icon];
    // 如果想要做一些牛逼的动画, 可以在这个位置来做
    [cell.layer removeAnimationForKey:@"rotation"];
    CAKeyframeAnimation *animatioan = [[CAKeyframeAnimation alloc]init];
    animatioan.keyPath = @"transform.rotation.x";
    animatioan.values = @[@(-1),@(0),@(1),@(0)];
    animatioan.duration = 0.5;
    [cell.layer addAnimation:animatioan forKey:@"rotation"];
    
    return cell;
    
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    YWCCarGroup *group = self.carGroups[section];
    return group.title;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.carGroups valueForKeyPath:@"title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
