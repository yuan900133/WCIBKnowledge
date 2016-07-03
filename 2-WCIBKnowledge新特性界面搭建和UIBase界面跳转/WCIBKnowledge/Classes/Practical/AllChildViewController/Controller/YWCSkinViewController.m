//
//  YWCSkinViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/7/3.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCSkinViewController.h"
#import "SkinTool.h"
@interface YWCSkinViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rectImageView;
@end

@implementation YWCSkinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    NSString *skinColor = [[NSUserDefaults standardUserDefaults] objectForKey:@"skinColor"];
    //
    //    if ([skinColor isEqualToString:@"green"]) {
    //        [self changeToGreenSkin];
    //    } else iuf
    //
    //    if (skinColor == nil) {
    //        skinColor = @"green";
    //    }
    //
    //    [self changeSkinWithSkinColor:skinColor];
    
    [self changeSkinImage];
}

- (IBAction)changeToGreenSkin {
    [SkinTool setSkinColor:@"green"];
    
    [self changeSkinImage];
}

- (IBAction)changeToRedSkin {
    [SkinTool setSkinColor:@"red"];
    
    [self changeSkinImage];
}

- (IBAction)changeToBlueSkin {
    [SkinTool setSkinColor:@"blue"];
    
    [self changeSkinImage];
}

- (IBAction)changeToOrangeSkin {
    [SkinTool setSkinColor:@"orange"];
    
    [self changeSkinImage];
}

- (void)changeSkinImage
{
    /*
     NSString *faceImageName = [NSString stringWithFormat:@"skin/%@/face", skinColor];
     self.faceImageView.image = [UIImage imageNamed:faceImageName];
     NSString *heartImageName = [NSString stringWithFormat:@"skin/%@/heart", skinColor];
     self.heartImageView.image = [UIImage imageNamed:heartImageName];
     NSString *rectImageName = [NSString stringWithFormat:@"skin/%@/rect", skinColor];
     self.rectImageView.image = [UIImage imageNamed:rectImageName];
     */
    
    // [SkinTool setSkinColor:skinColor];
    
    // 设置图片
    self.faceImageView.image = [SkinTool skinToolWithImageName:@"face"];
    self.heartImageView.image = [SkinTool skinToolWithImageName:@"heart"];
    self.rectImageView.image = [SkinTool skinToolWithImageName:@"rect"];
}

@end
