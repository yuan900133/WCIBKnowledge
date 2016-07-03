//
//  YWCAVViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/7/3.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCAVViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface YWCAVViewController ()
/** 播放器*/
@property(nonatomic ,strong) AVPlayerViewController *playerVC;
@end

@implementation YWCAVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playerVC = [[AVPlayerViewController alloc] init];
    
    
    // 创建一个avplayer
    NSURL *remoteURL = [NSURL URLWithString:@"http://v1.mukewang.com/57de8272-38a2-4cae-b734-ac55ab528aa8/L.mp4"];
    AVPlayer *player = [[AVPlayer alloc] initWithURL:remoteURL];
    
    self.playerVC.player = player;
    
    
    [self.view addSubview:self.playerVC.view];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //
    //    if (self.presentedViewController) {
    //        return;
    //    }
    //
    //    [self presentViewController:self.playerVC animated:YES completion:^{
    //        [self.playerVC.player play];
    //    }];
    //
    
    [self.playerVC.player play];
    
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.playerVC.view.frame = self.view.bounds;
}


@end
