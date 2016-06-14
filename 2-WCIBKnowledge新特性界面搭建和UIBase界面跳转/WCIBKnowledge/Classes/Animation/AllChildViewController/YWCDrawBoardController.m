//
//  YWCDrawBoardController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/14.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCDrawBoardController.h"
#import "YWCBoard.h"
#import "ImageHandleView.h"
@interface YWCDrawBoardController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,ImageHandleViewDelegate>
@property (weak, nonatomic) IBOutlet YWCBoard *drawView;




@end

@implementation YWCDrawBoardController

//清屏
- (IBAction)clear:(id)sender {
    [self.drawView clear];
}
//撤销
- (IBAction)undo:(id)sender {
    [self.drawView undo];
}
//橡皮擦
- (IBAction)erase:(id)sender {
    [self.drawView erase];
}

//照片
- (IBAction)photo:(id)sender {
    //弹出系统相册
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
    
    //设置照片的来源
    pick.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    pick.delegate = self;
    
    [self presentViewController:pick animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSLog(@"%@",info);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    
    ImageHandleView *handV = [[ImageHandleView alloc] init];
    handV.frame = self.drawView.frame;
    handV.image = image;
    handV.delegate = self;
    //    handV.backgroundColor = [UIColor redColor];
    [self.view addSubview:handV];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//当ImageHandleView内部图片长按时调用,
//image:截屏生成的图片.
-(void)imageHandleView:(ImageHandleView *)handleView newImage:(UIImage *)image{
    
    self.drawView.image = image;
    
}


//保存
- (IBAction)save:(id)sender {
    
    //对画板做截屏
    
    //1.创建一个位图上下文.(跟画板一样的尺寸大小)
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, NO, 0);
    //2.把画板的layer渲染到上下文当中.
    //获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.drawView.layer renderInContext:ctx];
    //3.从上下文当中生成一张图片
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    //4.把生成的图片写入到相册当中
    //completionTarget:写入完成时哪个对象来监听.
    //completionSelector:监听的方法
    //注意@selector:不能够乱写,必须得是- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    //5.关闭上下文.
    UIGraphicsEndImageContext();
    
    
}



- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    NSLog(@"保存成功");
}

- (void)saveSuccess{
    
    NSLog(@"保存成功");
}

//选择线宽
- (IBAction)chooseLineWith:(UISlider *)sender {
    [self.drawView setLineWidth:sender.value];
}

//选择颜色
- (IBAction)chooseColor:(UIButton *)sender {
    [self.drawView setLineColor:sender.backgroundColor];
}

@end
