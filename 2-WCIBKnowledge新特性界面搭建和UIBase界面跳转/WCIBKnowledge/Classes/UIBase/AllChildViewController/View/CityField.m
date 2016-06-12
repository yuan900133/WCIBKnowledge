

//
//  CityField.m
//  08-注册界面(拦截用户输入)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "CityField.h"
#import "Province.h"

#define FilePath(fileName) [[NSBundle mainBundle] pathForResource:fileName ofType:nil]

@interface CityField () <UIPickerViewDataSource,UIPickerViewDelegate>

// Pronvince
@property (nonatomic, strong) NSMutableArray *provinces;

@property (nonatomic, assign) NSInteger selProvinceIndex;

@end
@implementation CityField
static BOOL _isInital = NO;
- (void)initialText
{
    if (_isInital == NO) {
        
        [self pickerView:self.inputView didSelectRow:0 inComponent:0];
        
        _isInital = YES;
    }
}

- (NSMutableArray *)provinces
{
    if (_provinces == nil) {
        _provinces = [NSMutableArray array];
        // 解析plist
        NSArray *dictArr =[NSArray arrayWithContentsOfFile:FilePath(@"provinces.plist")];
        for (NSDictionary *dict in dictArr) {
            // 字典转模型
            Province *p = [Province provinceWithDict:dict];
            [_provinces addObject:p];
        }
    }
    
    return _provinces;
}
/*
 1.自定义键盘
 2.给自定义填充内容
 3.监听键盘选中
 
 */
- (void)awakeFromNib
{
    [self setUp];
}

// 初始化
- (void)setUp{
    
    // 创建pickerView
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    // 自定义城市键盘
    self.inputView = pickerView;
}

/*
 2列
 
 */

#pragma mark -UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
// 返回有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) { // 描述省,有多少个省就有多少行
        
        return self.provinces.count;
        
        
    }else{ // 描述第0列选中省的城市,选中省有多少个城市,就有多少行
        
        // 获取选中省的城市
        Province *p = self.provinces[_selProvinceIndex];
        
        return p.cities.count;
        
    }
    
}

#pragma mark -UIPickerViewDelegate

// 返回每一行内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) { // 描述省
        
        Province *p = self.provinces[row];
        
        return p.name;
        
    }else { // 描述选中省的城市
        // 获取选中省的城市
        Province *p = self.provinces[_selProvinceIndex];
        
        return  p.cities[row];
    }
    
}

// 选中某一行的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) { // 滚动第0列,选择省会
        _selProvinceIndex = row;
        // 记录当前选中的省会
        _selProvinceIndex = row;
        
        // 刷新第1列
        [pickerView reloadComponent:1];
        
        // 让第1列主动选中第0行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    
    // 设置文本框内容
    // 获取选中省的城市
    Province *p = self.provinces[_selProvinceIndex];
    
    // 获取选中的城市
    // 获取第1列选中的行
    NSInteger cityIndex = [pickerView selectedRowInComponent:1];
    NSString *cityName = p.cities[cityIndex];
    
    self.text = [NSString stringWithFormat:@"%@ %@",p.name,cityName];
    

    
    
}


@end
