

//
//  YWCShopWineCell.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/11.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCShopWineCell.h"
#import "YWCWine.h"
#import "YWCCircleButton.h"
@interface YWCShopWineCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet YWCCircleButton *minusButton;


@end
@implementation YWCShopWineCell

- (void)setWine:(YWCWine *)wine
{
    _wine = wine;
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%@",wine.image]];
    self.nameLabel.text = wine.name;
    self.moneyLabel.text = wine.money;
    
    // 根据模型的count属性决定countLabel显示的内容
    self.countLabel.text = [NSString stringWithFormat:@"%d",wine.count];
    // 根据count属性的值决定减号是否能点击
    self.minusButton.enabled = (wine.count > 0);
}

- (IBAction)plusClick {
    // 修改模型
    self.wine.count ++;
    // 修改界面
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.wine.count];
    
    // 减号能点击
    self.minusButton.enabled = YES;
    
}

- (IBAction)minusClick {
    // 修改模型
    self.wine.count --;
    // 修改界面
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.wine.count];
    
    // 减号按钮不能点击
    if (self.wine.count == 0) {
        self.minusButton.enabled = NO;
    }
    
}
@end
