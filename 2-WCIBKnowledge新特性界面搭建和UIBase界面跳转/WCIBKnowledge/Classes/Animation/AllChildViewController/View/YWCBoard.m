//
//  YWCBoard.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/14.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCBoard.h"
#import "MyBezierPath.h"

@interface YWCBoard()

/** 当前绘制的路径*/
@property(nonatomic ,strong) UIBezierPath *path;

/** 存放所有的路径*/
@property(nonatomic ,strong) NSMutableArray *pathArray;

/** 线的宽度*/
@property (nonatomic ,assign) CGFloat width;

/** 线的颜色*/
@property (nonatomic ,strong) UIColor *color;

@end
@implementation YWCBoard

-(void)setImage:(UIImage *)image{
    _image = image;
    [self.pathArray addObject:image];
    [self setNeedsDisplay];
}
//清屏
- (void)clear{
    
    //清空所有的路径
    [self.pathArray removeAllObjects];
    //重绘
    [self setNeedsDisplay];
    
}
//撤销
- (void)undo{
    //清空最后一条路径
    [self.pathArray removeLastObject];
    //重绘
    [self setNeedsDisplay];
    
}
//橡皮擦
- (void)erase{
    
    [self setLineColor:[UIColor whiteColor]];
    
}
//选择线宽
- (void)setLineWidth:(CGFloat)width{
    self.width = width;
}

//选择颜色
- (void)setLineColor:(UIColor *)color{
    self.color = color;
}

-(NSMutableArray *)pathArray{
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

-(void)awakeFromNib{
    
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    self.width = 1;
    self.color = [UIColor blackColor];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    //画线.
    //获取当前手指所在的点
    CGPoint curP =  [pan locationInView:self];
    
    if(pan.state == UIGestureRecognizerStateBegan){
        MyBezierPath *path = [MyBezierPath bezierPath];
        //设置线的宽度
        [path setLineWidth:self.width];
        //设置线的颜色
        path.color = self.color;
        [self.pathArray addObject:path];
        self.path = path;
        [path moveToPoint:curP];
    }else if (pan.state == UIGestureRecognizerStateChanged){
        
        //添加一根线到当前手指所在的点.
        [self.path addLineToPoint:curP];
        
        [self setNeedsDisplay];
    }
    
}


-(void)drawRect:(CGRect)rect{
    
    //取出保存的所有路径进行绘制
    for (MyBezierPath *path in self.pathArray) {
        
        if ([path isKindOfClass:[UIImage class]]) {
            //如果是图片, 取出图片,把图片绘制到View.
            UIImage *image= (UIImage *)path;
            [image drawInRect:rect];
            
        }else{
            [path.color set];
            [path stroke];
        }
        
    }
    
    
    
}

@end
