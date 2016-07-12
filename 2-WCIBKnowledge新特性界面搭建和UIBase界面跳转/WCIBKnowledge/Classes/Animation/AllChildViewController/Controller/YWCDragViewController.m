
//
//  YWCDragViewController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/12.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCDragViewController.h"
#define screenW [UIScreen mainScreen].bounds.size.width

#define screenH [UIScreen mainScreen].bounds.size.height
@interface YWCDragViewController ()

@end

@implementation YWCDragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加子控件
    [self setUp];
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.mainV addGestureRecognizer:pan];
    
    //添加点按手势控制器的View.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    
    [self.view addGestureRecognizer:tap];
    
    
}

//让mainV做复位操作
- (void)tap{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.mainV.frame = self.view.bounds;
    }];
}




#define tartgetR 275
#define tartgetL -275



//当手指在MainV上移动时调用
- (void)pan:(UIPanGestureRecognizer *)pan{
    
    //    NSLog(@"%s",__func__);
    //获取手指移动偏移量
    CGPoint transP = [pan translationInView:self.mainV];
    //    self.mainV.transform = CGAffineTransformTranslate(self.mainV.transform, transP.x, 0);
    
    self.mainV.frame = [self frameWithOffsetX:transP.x];
    NSLog(@"%f",self.mainV.frame.origin.x);
    if (self.mainV.frame.origin.x > 0) {
        //往右边拖动.隐藏右边的View.
        self.rightV.hidden = YES;
    } else if(self.mainV.frame.origin.x < 0){
        //往左边拖动.显示右边的View.
        self.rightV.hidden = NO;
    }
    
    
    //手指松开时做定位.
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat target = 0;
        if (self.mainV.frame.origin.x > screenW * 0.5) {
            //1.判断当前MainV.x如果大于屏幕宽度一半时, 定位到右边.
            target = tartgetR;
        }
        else if (CGRectGetMaxX(self.mainV.frame) < screenW *0.5){
            target = tartgetL;
        }
        
        CGFloat offsetX = target - self.mainV.frame.origin.x;
        [UIView animateWithDuration:0.25 animations:^{
            
            self.mainV.frame = [self frameWithOffsetX:offsetX];
        }];
        
    }
    
    //复位
    [pan setTranslation:CGPointZero inView:self.mainV];
    
}

#define maxY 100
//根据一个偏移量计算mainV的frame
- (CGRect)frameWithOffsetX:(CGFloat)offsetX{
    
    NSLog(@"offsetX==%f",offsetX);
    //获取最原始的Frame
    CGRect frame = self.mainV.frame;
    //每次累加计算x值
    frame.origin.x += offsetX;
    NSLog(@"frame.origin.x==%f",frame.origin.x);
    //当mainV的x值,正好等于屏幕宽度时,当前的MainV的Y值最大.
    //当x值为负时,计算的结果是负的,那么y就会往上走,,所以要一个绝对值.
    frame.origin.y =  fabs(frame.origin.x * maxY / screenW);
    //MainV的高度等于屏幕的高度- 2倍的MainV的Y值.
    frame.size.height = screenH - (2 * frame.origin.y);
    
    return frame;
}


//添加子控件
- (void)setUp{
    
    //创建左边的View
    UIView *leftV = [[UIView alloc] initWithFrame:self.view.bounds];
    leftV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"15"]];
    self.leftV = leftV;
    [self.view addSubview:leftV];
    //创建右边的View
    UIView *rightV = [[UIView alloc] initWithFrame:self.view.bounds];
    rightV.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"5"]];
    self.rightV = rightV;
    [self.view addSubview:rightV];
    //MainV
    UIView *mainV = [[UIView alloc] initWithFrame:self.view.bounds];
    mainV.backgroundColor = [UIColor grayColor];
    self.mainV = mainV;
    [self.view addSubview:mainV];
    
    
}

@end
