
//
//  WheelView.m
//  14-转盘(界面搭建)
//
//  Created by 袁武昌 on 16/5/22.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "WheelView.h"

#import "WheelBtn.h"
@interface WheelView()

@property (weak, nonatomic) IBOutlet UIImageView *contentView;
/** 当前选中的按钮*/
@property (nonatomic, weak) UIButton *selectBtn;
/** 定时器*/
@property(nonatomic ,strong) CADisplayLink *link;
@end
@implementation WheelView
-(CADisplayLink *)link{
    
    if (_link == nil) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _link =  link;
    }
    return _link;
}


//开始选号
- (IBAction)startChoose:(id)sender {
    //让定时器暂停
    self.link.paused = YES;
    //快速旋转几圈,动画结束时,选中的按钮指向最上方.
    //创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(M_PI * 4);
    anim.duration = 1;
    anim.delegate = self;
    [self.contentView.layer addAnimation:anim forKey:nil];
    
}

- (void)awakeFromNib{
    
    [self setUp];
}

//初始化
- (void)setUp{
    
    
    self.contentView.userInteractionEnabled = YES;
    CGFloat btnW = 68;
    CGFloat btnH = 143;
    CGFloat angle = 0;
    
    //加载原始图片
    UIImage *oriNorImage = [UIImage imageNamed:@"LuckyAstrology"];
    NSLog(@"%@",NSStringFromCGSize(oriNorImage.size));
    
    NSLog(@"%f",[UIScreen mainScreen].scale);
    CGFloat clipW = oriNorImage.size.width / 12 * [UIScreen mainScreen].scale;
    CGFloat clipH = oriNorImage.size.height * [UIScreen mainScreen].scale;
    CGFloat clipX = 0;
    CGFloat clipY = 0;
    
    
    for (int i = 0; i < 12; i++) {
        //创建按钮
        WheelBtn *btn = [WheelBtn buttonWithType:UIButtonTypeCustom];
        btn.bounds = CGRectMake(0, 0, btnW, btnH);
        //设置锚点
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        //设置position
        btn.layer.position = CGPointMake(self.contentView.bounds.size.width * 0.5, self.contentView.bounds.size.height * 0.5);
        
        
        //裁剪图片
        clipX = i * clipW;
        CGRect rect =  CGRectMake(clipX, clipY, clipW, clipH);
        //在CoreGraphics框架当中使用的都是像素坐标.
        //在UIKit框架当中,使用的都是点坐标.
        UIImage *useImage  = [UIImage imageWithCGImage:oriNorImage.CGImage];
        NSLog(@"%@",NSStringFromCGSize(useImage.size));
        
        CGImageRef clipOriImage =  CGImageCreateWithImageInRect(oriNorImage.CGImage,rect);
        //设置正常状态下,按钮显示的图片
        //把CGImageRef转成UIImage;
        [btn setImage:[UIImage imageWithCGImage:clipOriImage] forState:UIControlStateNormal];
        

        //设置选中状态下的图片
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        //        btn.backgroundColor = [UIColor redColor];
        btn.transform = CGAffineTransformMakeRotation(angle / 180.0 * M_PI);
        angle += 30;
        //监听按钮的点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //默认让第0个按钮成为选中状态.
        if (i == 0) {
            [self btnClick:btn];
        }
        [self.contentView addSubview:btn];
    }
    
}

//点击按钮时调用.
- (void)btnClick:(UIButton *)btn{
    
    //1.让当前选中的按钮取消选中.
    self.selectBtn.selected = NO;
    //2.让当前点击的按钮成为选中状态.
    btn.selected = YES;
    //3.把当前点击的按钮赋值给当前选中的按钮
    self.selectBtn = btn;
}


- (void)start{
    
    //创建动画对象
    //    CABasicAnimation *anim = [CABasicAnimation animation];
    //    anim.keyPath = @"transform.rotation";
    //    anim.toValue = @(M_PI * 2);
    //    anim.repeatCount = MAXFLOAT;
    //    anim.duration = 5;
    //    [self.contentView.layer addAnimation:anim forKey:nil];
    //添加一个定时器,让每一次在上一个基础旋转一个角度.
    self.link.paused = NO;
    
}

- (void)stop{
    
    self.link.paused = YES;
}


- (void)update{
    self.contentView.transform = CGAffineTransformRotate(self.contentView.transform, M_PI / 300.0);
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"WheelView" owner:nil options:nil][0];
    }
    return self;
}

+ (instancetype)wheelView{
    return [[NSBundle mainBundle] loadNibNamed:@"WheelView" owner:nil options:nil][0];
}

@end
