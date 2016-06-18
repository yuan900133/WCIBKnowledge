

//
//  YWCShadowController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/16.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCShadowController.h"
#import "YWCShadowView.h"
@interface YWCShadowController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (strong, nonatomic) IBOutlet YWCShadowView *vcView;

@end

@implementation YWCShadowController
- (IBAction)start:(id)sender {
    [self.vcView start];
}
- (IBAction)redraw:(id)sender {
    
    [self.vcView redraw];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   
    
    CAReplicatorLayer *repL = (CAReplicatorLayer *)self.view.layer;
    repL.instanceCount = 2;
    
    //让复制出来的子层绕着X轴旋转180度
    //它是绕着复制层的锚点进行旋转.
    repL.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    //设置倒影
    repL.instanceRedOffset -= 0.1;
    repL.instanceGreenOffset -= 0.1;
    repL.instanceBlueOffset -= 0.1;
    repL.instanceAlphaOffset -= 0.1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
