//
//  YWCBoxViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/7/3.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCBoxViewController.h"

@interface YWCBoxViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *box1;
@property (weak, nonatomic) IBOutlet UIImageView *box2;
@property (weak, nonatomic) IBOutlet UIImageView *box3;
/** 物理仿真器*/
@property(nonatomic ,strong) UIDynamicAnimator *animator;
@end

@implementation YWCBoxViewController

-(UIDynamicAnimator *)animator
{
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self gravityAnimator];
    //    [self collisionBehavior];
    
    //    CGPoint p = [[touches anyObject] locationInView:self.view];
    //    [self snapBehavior:p];
    
    [self gravityAnimator];
    [self collisionBehavior];
}


- (void)pushBehavior
{
    /**
     UIPushBehaviorModeContinuous, // 持续推,
     UIPushBehaviorModeInstantaneous // 推一次
     */
    
    UIPushBehavior *behavior = [[UIPushBehavior alloc] initWithItems:@[self.box1] mode:UIPushBehaviorModeContinuous];
    
    // 推动行为, 必须告知, 推动的方向
    behavior.pushDirection = CGVectorMake(0, -50);
    [self.animator addBehavior:behavior];
}


-(void)snapBehavior:(CGPoint)point
{
    // 捕捉行为有一个注意事项, 如果想多吃执行这个行为, 需要先把之前的捕捉行为移除
    [self.animator removeAllBehaviors];
    
    UISnapBehavior *behavior = [[UISnapBehavior alloc] initWithItem:self.box1 snapToPoint:point];
    
    // 设置捕捉的振幅
    behavior.damping = 0.0;
    
    
    [self.animator addBehavior:behavior];
}

// 碰撞行为
- (void)collisionBehavior
{
    // 1. 创建行为
    UICollisionBehavior *behavior = [[UICollisionBehavior alloc] initWithItems:@[self.box1, self.box2, self.box3]];
    
    // 1.1 设置碰撞的边界
    // 将参考视图边界当做碰撞的边界
    behavior.translatesReferenceBoundsIntoBoundary = YES;
    
    // 设置两个点组成的一个线段当做碰撞边界
    //    [behavior addBoundaryWithIdentifier:@"line" fromPoint:CGPointMake(0, 380) toPoint:CGPointMake(self.view.frame.size.width, 500)];
    
    // 1.2 设置碰撞模式
    /**
     *      UICollisionBehaviorModeItems       // 只可以碰撞元素
     UICollisionBehaviorModeBoundaries   // 之碰撞边界
     UICollisionBehaviorModeEverything  // 啥玩意都碰撞
     */
    behavior.collisionMode = UICollisionBehaviorModeEverything;
    
    
    // 2. 添加行为到仿真器
    [self.animator addBehavior:behavior];
    
}


// 重力行为
-(void)gravityAnimator
{
    // 1. 创建重力行为
    UIGravityBehavior *behavior = [[UIGravityBehavior alloc] initWithItems:@[self.box1,self.box2,self.box3]];
    
    // 1.1 设置重力方向
    //    behavior.angle = 0;
    
    // 1.2 设置重力量级
        behavior.magnitude = 10;
    
    
    // 2. 把行为添加仿真器中
    [self.animator addBehavior:behavior];
    
    
    
}

@end
