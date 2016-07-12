
//
//  YWCSnow.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/14.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCSnow.h"

@interface YWCSnow ()

@property(nonatomic,strong)CADisplayLink *link;
@end
@implementation YWCSnow

-(void)awakeFromNib{
    
    //添加定时器
    //    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeChange)];
    _link = link;
    //想要让CADisplayLink开始工作, 必须得要把它添加到主运行循环当中 .
    //CADisplayLink,当每一次屏幕刷新时,就会调用定时器方法.(屏幕一秒刷新60次)
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
- (void)dealloc
{
    [self.link invalidate];
}

- (void)timeChange{
    
     NSInteger addY = arc4random_uniform(10);
    
    _snowY += addY;
    
    if (_snowY > [UIScreen mainScreen].bounds.size.height) {
        _snowY = 0;
    }
    //重绘
    //会调用drawRect,它并不是立马调用drawRect,它只是设置了一个标志.当下次屏幕刷新时,才去调用drawRect.
    [self setNeedsDisplay];
    NSLog(@"%s",__func__);
}

static int  _snowY = 0;
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //加载图片
    UIImage *image = [UIImage imageNamed:@"雪花"];
    NSInteger _nowx = arc4random_uniform(300);
    NSInteger _nowx1 = arc4random_uniform(300);
    NSInteger _nowx2 = arc4random_uniform(300);
    NSInteger _nowx3 = arc4random_uniform(300);
    
    [image drawAtPoint:CGPointMake(_nowx, _snowY)];
    
    //加载图片
    UIImage *image1 = [UIImage imageNamed:@"雪花"];
    [image1 drawAtPoint:CGPointMake(_nowx1, _snowY)];
    //加载图片
    UIImage *image2 = [UIImage imageNamed:@"雪花"];
    [image2 drawAtPoint:CGPointMake(_nowx2, _snowY)];
    //加载图片
    UIImage *image3 = [UIImage imageNamed:@"雪花"];
    [image3 drawAtPoint:CGPointMake(_nowx3, _snowY)];
    
}




@end
