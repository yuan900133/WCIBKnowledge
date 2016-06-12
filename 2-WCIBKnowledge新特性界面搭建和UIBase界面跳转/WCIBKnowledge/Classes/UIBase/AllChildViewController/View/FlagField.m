//
//  FlagField.m
//  08-注册界面(拦截用户输入)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "FlagField.h"
#import "Flag.h"
#import "FlagView.h"

#define FilePath(fileName) [[NSBundle mainBundle] pathForResource:fileName ofType:nil]

@interface FlagField ()<UIPickerViewDataSource,UIPickerViewDelegate>
// Flag
@property (nonatomic, strong) NSMutableArray *flags;

@end
@implementation FlagField
static BOOL _isInital = NO;

// 初始化国旗文本框
- (void)initialText
{
    if (_isInital == NO) {
        
        [self pickerView:nil didSelectRow:0 inComponent:0];
        
        _isInital = YES;
    }
}


- (NSMutableArray *)flags
{
    if (_flags == nil) {
        
        // 初始化数组
        _flags = [NSMutableArray array];
        
        // 解析plist文件
        // 获取文件全路径
        NSArray *dictArr =[NSArray arrayWithContentsOfFile:FilePath(@"flags.plist")];
        for (NSDictionary *dict in dictArr) {
            // 字典转模型
            Flag *flag = [Flag flagWithDict:dict];
            [_flags addObject:flag];
        }
        
    }
    return _flags;
}

// 从xib,storyboard创建就会调用
- (void)awakeFromNib
{
    // 初始化
    [self setUp];
}

// 初始化
- (void)setUp
{
    // 创建UIPickerView
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    // 设置数据源和代理
    pickerView.dataSource = self;
    
    pickerView.delegate = self;
    // 自定义键盘
    // inputView:设置文本框的键盘
    self.inputView = pickerView;
    
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// 返回多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.flags.count;
}

#pragma mark - UIPickerViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    // 获取模型
    Flag *flag = self.flags[row];
    
    // 从xib加载控件,默认一个控件的尺寸跟xib一样大
    FlagView *flagView = [FlagView flagView];
    
    // 修改宽度
    CGRect frame = flagView.frame;
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    flagView.frame = frame;
    
    // 设置模型
    flagView.flag = flag;
    
    return flagView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 80;
}

// 选中某一行就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 获取选中的模型
    Flag *flag = self.flags[row];
    
    self.text = flag.name;
}


@end
