//
//  YWCGameController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/9.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCGameController.h"
#import <AVFoundation/AVFoundation.h>
@interface YWCGameController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong)NSArray *standImages;
@property(nonatomic, strong)NSArray *smallZhaoIamges;
@property(nonatomic, strong)NSArray*bigZhaoImages;
@property (nonatomic,strong)AVPlayer *player;

@end

@implementation YWCGameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"15"]];
//    self.view.backgroundColor = YWCRandomColor;
    
    //   站立
    self.standImages = [self loadImagesWithPrefix:@"stand" count:10];
    self.smallZhaoIamges = [self loadImagesWithPrefix:@"xiaozhao1" count:21];
    self.bigZhaoImages =  [self loadImagesWithPrefix:@"dazhao" count:87];
    
    
//    NSURL *url = [[NSBundle mainBundle]URLForResource:@"dazhao.mp3" withExtension:nil];
//    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:url];
//    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    
    
}
- (NSArray *)loadImagesWithPrefix:(NSString *)prefix count:(NSInteger)count;
{
    //   站立
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i< count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%@_%d",prefix,i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_%d",prefix,i+1] ofType:nil];
//        
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        [images addObject:image];
    }
    return images;
    
}


- (IBAction)standBtnClick:(id)sender {
    
    self.imageView.animationRepeatCount = 0;
    self.imageView.animationImages = self.standImages;
    
    [self.imageView startAnimating];
}
- (IBAction)smallZhaoBtnClick:(id)sender {
    
    [self playAnimationWithImages:self.smallZhaoIamges withSoundName:nil];
    
    
}
- (IBAction)bigZhaoBtnClick:(id)sender {
    [self playAnimationWithImages:self.bigZhaoImages withSoundName:nil];
}

- (void)playAnimationWithImages:(NSArray *)images withSoundName:(NSString *)soundName
{
    
    self.imageView.animationImages = images;
    self.imageView.animationRepeatCount = 1;
    [self.imageView startAnimating];
    
    
//    NSTimeInterval zhaoTime = 1/30.0 *images.count;
//    
//    [self performSelector:@selector(standBtnClick:) withObject:nil afterDelay:zhaoTime];
    
//    NSURL *url = [[NSBundle mainBundle]URLForResource:soundName withExtension:@"mp3"];
//    
//    AVPlayerItem *replaceItem = [[AVPlayerItem alloc]initWithURL:url];
//    
//    [self.player replaceCurrentItemWithPlayerItem:replaceItem];
//    [self.player play];
//    self.player.rate = 1.5;
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self gameOver:nil];
}
- (IBAction)gameOver:(id)sender {
    self.standImages = nil;
    self.smallZhaoIamges = nil;
    self.bigZhaoImages = nil;
    
    
    
    self.imageView.animationImages = nil;
}

@end
