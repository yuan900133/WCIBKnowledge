
//
//  ClockView.m
//  07-手势解锁(搭建界面)
//
//  Created by 袁武昌 on 16/5/21.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "ClockView.h"
@interface ClockView()

/** 保存选中状态的按钮*/
@property(nonatomic ,strong) NSMutableArray *selectBtnArray;
/** 当前手指所在的点*/
@property (nonatomic ,assign) CGPoint curP;

@end
@implementation ClockView
-(NSMutableArray *)selectBtnArray{
    
    if (_selectBtnArray == nil) {
        _selectBtnArray = [NSMutableArray array];
    }
    return _selectBtnArray;
}
- (void)awakeFromNib{
    
    //初始化
    [self setUp];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        //初始化
        [self setUp];
    }
    return self;
}

//获取当前手指的点.
- (CGPoint)getCurrentPoint:(NSSet *)touches{
    //获取当前手指的点.
    UITouch *touch = [touches anyObject];
    CGPoint curP = [touch locationInView:self];
    return curP;
}

//判断一个点在不在按钮身上.
- (UIButton *)btnRectContainsPoint:(CGPoint)point{
    
    //取出所有按钮,判断当前手指的点,在不在按钮上.
    for (UIButton *btn in self.subviews) {
        
        if ( CGRectContainsPoint(btn.frame, point)) {
            //当前点在按钮身上.
            //            btn.selected = YES;
            return btn;
        }
    }
    return nil;
}

//当手指开始点击时, 让按钮成为选中状态.
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取当前手指的点.
    CGPoint curP = [self getCurrentPoint:touches];
    //判断一个点在不在按钮身上.
    UIButton *btn = [self btnRectContainsPoint:curP];
    if (btn && btn.selected == NO) {//当按钮没有选中状态时,才让按钮成为选中状态.
        btn.selected = YES;
        [self.selectBtnArray addObject:btn];
    }
    
}
//当手指移动时, 让如果点在按钮上, 让按钮成为选中状态.
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取当前手指的点.
    CGPoint curP = [self getCurrentPoint:touches];
    self.curP = curP;
    //取出所有按钮,判断当前手指的点,在不在按钮上.
    //判断一个点在不在按钮身上.
    UIButton *btn = [self btnRectContainsPoint:curP];
    
    if (btn && btn.selected == NO) {//当按钮没有选中状态时,才让按钮成为选中状态.
        btn.selected = YES;
        [self.selectBtnArray addObject:btn];
    }
    //重绘
    [self setNeedsDisplay];}
//当手指离开时, 让按钮取消选中.

//当手指离开时, 让按钮取消选中.
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //遍历出所有的选中按钮
    
    NSMutableString *str = [NSMutableString string];
    for (UIButton *btn in self.selectBtnArray) {
        //让按钮取消选中
        btn.selected = NO;
        [str appendFormat:@"%ld",btn.tag];
    }
    
    NSLog(@"选中按钮的顺序:%@",str);
    
    //清空选中按钮的数组
    [self.selectBtnArray removeAllObjects];
    //重绘
    [self setNeedsDisplay];
    
    
}

//初始化
- (void)setUp{
    
    //添加按钮
    for (int i = 0;  i < 9; i++) {
        //创建按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        [self addSubview:btn];
    }
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    //总列数
    int cloumn = 3;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat btnWH = 74;
    CGFloat margin = (self.bounds.size.width - (btnWH * cloumn)) / (cloumn + 1);
    
    //当前所在列
    int curCloumn = 0;
    //当前所在的行
    int curRow = 0;
    
    for ( int i = 0;  i < self.subviews.count; i++) {
        //当前所在列
        curCloumn = i % cloumn;
        //当前所在的行
        curRow = i / cloumn;
        
        x = margin + (btnWH + margin) * curCloumn;
        y = (btnWH + margin) * curRow;
        //出取每一个按钮
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, btnWH, btnWH);
    }
    
    
}


-(void)drawRect:(CGRect)rect{
    
    if (self.selectBtnArray.count) {
        
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        //取出所有选中的按钮
        for(int i = 0 ; i < self.selectBtnArray.count; i++){
            UIButton *btn = self.selectBtnArray[i];
            //如果发现按钮是第一个, 让按钮成为路径的起点.
            if (i == 0) {
                [path moveToPoint:btn.center];
            }else{
                [path addLineToPoint:btn.center];
            }
        }
        //添加一根线到当前手指的点.
        [path addLineToPoint:self.curP];
        
        //设置连接样式
        [path setLineJoinStyle:kCGLineJoinRound];
        
        //设置线宽度
        [path setLineWidth:10];
        //设置颜色
        [[UIColor redColor] set];
        [path stroke];
        
        
    }

    
}


@end
