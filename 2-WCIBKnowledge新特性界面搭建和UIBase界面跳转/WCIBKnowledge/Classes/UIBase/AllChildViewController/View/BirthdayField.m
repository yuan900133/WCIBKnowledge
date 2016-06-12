//
//  BirthdayField.m
//  08-注册界面(拦截用户输入)
//
//  Created by 袁武昌 on 16/5/15.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "BirthdayField.h"

@implementation BirthdayField

static BOOL _isInital = NO;

- (void)initialText
{
    if (_isInital == NO) {
        
        [self dateChange:self.inputView];
        _isInital = YES;
    }
    
    
}
- (void)awakeFromNib
{
    [self setUp];
}

// 初始化
- (void)setUp
{
    // 创建日期选择控件
    UIDatePicker *dataPicker = [[UIDatePicker alloc] init];
    
    // 设置中文 zh:中国
    dataPicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    // 设置日期显示模式
    dataPicker.datePickerMode = UIDatePickerModeDate;
    
    [dataPicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    // 自定义生日键盘
    self.inputView = dataPicker;
}

- (void)dateChange:(UIDatePicker *)datePicker
{
    //    NSLog(@"%@",datePicker.date);
    // NSDate -> NSString
    // 2015-11-01
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    self.text = [fmt stringFromDate:datePicker.date];
}

@end
