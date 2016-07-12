//
//  YWCRefreshViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/11.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCRefreshViewController.h"
#import "MJExtension.h"
#import "YWCWine.h"
#import "YWCWineCell.h"
@interface YWCRefreshViewController ()
<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *wineArray;
@property (weak, nonatomic) IBOutlet UIButton *deletedBtn;
/** 保存用户选中的cell的indexPath*/
@property(nonatomic ,strong)NSMutableArray *seletedIndexPaths;

@end

@implementation YWCRefreshViewController

- (NSMutableArray *)seletedIndexPaths
{
    if (!_seletedIndexPaths) {
        _seletedIndexPaths = [NSMutableArray array];
    }
    return _seletedIndexPaths;
}

- (NSMutableArray *)wineArray
{
    if (_wineArray == nil) {
        _wineArray = [YWCWine mj_objectArrayWithFilename:@"wine.plist"];
    }
    return _wineArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // 设置tableView在编辑模式下可以多选
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
}

- (IBAction)add:(id)sender {
    // 修改模型
    YWCWine *wine = [[YWCWine alloc] init];
    wine.name = @"女儿红";
    wine.money = @"67.9";
    wine.image = @"newWine";
    //    [self.wineArray addObject:wine];
    [self.wineArray insertObject:wine atIndex:0];
    
    // 刷新表格(告诉tableView数据变了,赶紧刷新)
    [self.tableView reloadData];

    
}
- (IBAction)update:(id)sender {
    // 修改模型
    YWCWine  *wine = self.wineArray[0];
    wine.money = @"400";
    // 刷新表格(全局刷新)
    [self.tableView reloadData];
    
}
- (IBAction)remove:(id)sender {
    // 进入编辑模式
    //    self.tableView.editing = !self.tableView.isEditing;
    //    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    //    self.deletedBtn.hidden = !self.tableView.isEditing;
    // 获取所有要删除的模型
    NSMutableArray *deletedWine = [NSMutableArray array];
    for (NSIndexPath *indexPath in self.seletedIndexPaths) {
        [deletedWine addObject:self.wineArray[indexPath.row]];
    }
    
    // 删除模型
    [self.wineArray removeObjectsInArray:deletedWine];
    
    // 刷新表格
    //    [self.tableView reloadData];
    [self.tableView deleteRowsAtIndexPaths:self.seletedIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // 清空数组
    [self.seletedIndexPaths removeAllObjects];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.wineArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"wine";
    YWCWineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell =[[YWCWineCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.wine = self.wineArray[indexPath.row];
    
    [cell.layer removeAnimationForKey:@"rotation"];
    CAKeyframeAnimation *animatioan = [[CAKeyframeAnimation alloc]init];
    animatioan.keyPath = @"transform.rotation.z";
    animatioan.values = @[@(-1),@(0),@(1),@(0)];
    animatioan.duration = 0.5;
    [cell.layer addAnimation:animatioan forKey:@"rotation"];
    
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YWCWine *wine = self.wineArray[indexPath.row];
    if (wine.isChecked) { // 之前是打钩,现在取消打钩
        wine.checked = NO;
        [self.seletedIndexPaths removeObject:indexPath];
    } else { // 之前是取消打钩的,现在需要打钩
        wine.checked = YES;
        [self.seletedIndexPaths addObject:indexPath];
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
