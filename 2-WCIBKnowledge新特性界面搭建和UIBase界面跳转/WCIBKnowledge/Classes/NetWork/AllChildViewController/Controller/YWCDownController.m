
//
//  YWCDownController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/19.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCDownController.h"
#import "YWCApp.h"
#import <UIImageView+WebCache.h>
@interface YWCDownController ()
/** tableView的数据源*/
@property(nonatomic ,strong) NSArray *apps;
/** 图片缓存*/
@property(nonatomic ,strong) NSMutableDictionary *images;
/** */
@property(nonatomic ,strong) NSOperationQueue *queue;

@property(nonatomic ,strong) NSMutableDictionary *operations;


@end

@implementation YWCDownController

#pragma mark -------------------
#pragma mark lazy Loading
-(NSArray *)apps
{
    if (_apps == nil) {
        NSArray *appsArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil]];
        
        NSLog(@"%@",appsArray);
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:appsArray.count];
        //字典转模型  字典数组--->模型数组
        for (NSDictionary *dict in appsArray) {
            [arrayM addObject:[YWCApp appWithDict:dict]];
        }
        
        _apps = arrayM;
    }
    return _apps;
}


-(NSMutableDictionary *)images
{
    if (_images == nil) {
        _images = [NSMutableDictionary dictionary];
    }
    return _images;
}

-(NSOperationQueue *)queue
{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc]init];
        _queue.maxConcurrentOperationCount = 5;
    }
    return _queue;
}

-(NSMutableDictionary *)operations
{
    if (_operations == nil) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}
#pragma mark -------------------
#pragma mark  UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.apps.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.创建cell
    static NSString *ID = @"app";
   UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    
    //2.设置cell的数据
    //2.1 拿到这个cell对应的数据
    YWCApp *app = self.apps[indexPath.row];
    
    //2.2 设置文字
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //2.3 设置图片
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:app.icon] placeholderImage:[UIImage imageNamed:@"1"]];
    
    return cell;
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //1.创建cell
//    static NSString *ID = @"app";
//    
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    
//    //2.设置cell的数据
//    //2.1 拿到这个cell对应的数据
//    YWCApp *app = self.apps[indexPath.row];
//    
//    //2.2 设置文字
//    cell.textLabel.text = app.name;
//    cell.detailTextLabel.text = app.download;
//    
//    //2.3 设置图片
//    UIImage *image = [self.images objectForKey:app.icon];
//    
//    if (image) {
//        cell.imageView.image = image;
//    }else
//    {
//        //拿到沙盒的路径
//        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        //文件名称
//        NSString *fileName = [app.icon lastPathComponent];
//        //拼接文件的全路径
//        NSString *fullPath = [caches stringByAppendingPathComponent:fileName];
//        
//        //        NSLog(@"%@",fullPath);
//        NSData *data = [NSData dataWithContentsOfFile:fullPath];
//        
//        data = nil;
//        if (data) {
//            UIImage *image = [UIImage imageWithData:data];
//            cell.imageView.image = image;
//            //保存已经下载完成的图片
//            self.images[app.icon] = image;
//        }else
//        {
//            NSBlockOperation *download = self.operations[app.icon];
//            if (download) {
//                //什么不干,就像大爷一样
//            }else
//            {
//                //                cell.imageView.image = [UIImage imageNamed:@"Snip20151124_183"];
//                download = [NSBlockOperation blockOperationWithBlock:^{
//                    
//                    NSURL *url = [NSURL URLWithString:app.icon];
//                    NSData *data = [NSData dataWithContentsOfURL:url];
//                    UIImage *image = [UIImage imageWithData:data];
//                    
//                    if (data == nil) {
//                        self.operations[app.icon] = download;
//                        return ;
//                    }
//                    //                    [NSThread sleepForTimeInterval:2.0];
//                    NSLog(@"%zd---",indexPath.row);
//                    //保存已经下载完成的图片
//                    
//                    //                    self.images[app.icon] = image;
//                    [self.images setObject:image forKey:app.icon];
//                    
//                    //保存到沙盒
//                    [data writeToFile:fullPath atomically:YES];
//                    
//                    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//                        //                        cell.imageView.image = image;
//                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//                    }];
//                    
//                    //把操作从缓存中移除
//                    [self.operations removeObjectForKey:app.icon];
//                }];
//                
//                [self.queue addOperation:download];
//                
//                //把操作添加到操作缓存里面
//                self.operations[app.icon] = download;
//            }
//        }
//    }
//    
//    //3.返回cell
//    return cell;
//}
//
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
/*
 Documents:会备份,不允许把下载的文件存放在这个文件夹
 Library
 caches:缓存
 perfence:偏好设置
 Tmp:临时文件,里面的数据随时会被删除
 */
/*
 问题:
 问题1:UI不流畅 --->开子线程去下载图片
 新的问题:
 1)重复下载(下载操作重复添加)
 2)图片不显示--->设置展位图片
 3)
 问题2:重复下载--->内存缓存--->优化(沙盒缓存)
 */
@end
