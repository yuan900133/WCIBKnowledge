//
//  YWCVideoController.m
//  WCIBKnowledge
//
//  Created by 袁武昌 on 16/6/19.
//  Copyright © 2016年 yuan.com. All rights reserved.
//

#import "YWCVideoController.h"

#import <UIImageView+WebCache.h>
#import "YWCVideo.h"
#import <MediaPlayer/MediaPlayer.h>
#define  KBaseUrl @"http://120.25.226.186:32812"


#import <MJExtension/MJExtension.h>


@interface YWCVideoController ()
/** tableView的数据源*/
@property(nonatomic ,strong) NSArray *videos;
@end

@implementation YWCVideoController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //0设置替换模型中的属性
    [YWCVideo mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID":@"id",
                 };
    }];
    //1.确定请求路径
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/video?type=JSON"];
    
    //2.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3.使用NSURLConnection发送GET请求(异步)
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        //4.解析服务器返回的数据
        NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        
        //5.设置TableView的数据源
        //self.videos = dict[@"videos"];
        
        //字典转模型
        NSArray *arrayM = dict[@"videos"];
        //        NSMutableArray *videoArray = [NSMutableArray arrayWithCapacity:arrayM.count];
        //        for (NSDictionary *dict in arrayM) {
        //            [videoArray addObject:[XMGVideo videoWithDict:dict]];
        //        }
        
        //直接使用框架来进行字典转模型
        self.videos = [YWCVideo mj_objectArrayWithKeyValuesArray:arrayM];
        
        //处理复杂JSON数据
        //1.在线格式化:http://tool.oschina.net/codeformat/json
        //2.写文件 [dict writeToFile:@"/Users/a1/Desktop/video.plist" atomically:YES];
        
        //6.在主线程中刷新UI-TableView
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"video";
    //1.创建cell
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //2.设置cell的数据
    //拿到该行cell对应的数据
    YWCVideo *video = self.videos[indexPath.row];
    /*
     //NSDictionary *dictM = self.videos[indexPath.row];
     
     //cell.textLabel.text = [dictM objectForKey:@"name"];
     //cell.detailTextLabel.text = [NSString stringWithFormat:@"播放时间:%@",dictM[@"length"]];
     
     //NSString *imageStr = [KBaseUrl stringByAppendingPathComponent:dictM[@"image"]];
     //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"Snip20151128_63"]];
     */
    
    cell.textLabel.text = video.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"播放时间:%@",video.length];
    
    NSString *imageStr = [KBaseUrl stringByAppendingPathComponent:video.image];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"Snip20151128_63"]];
    
    //3.返回cell
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //拿到该行cell对应的数据
    /*
     //NSDictionary *dictM = self.videos[indexPath.row];
     
     //NSURL *url = [NSURL URLWithString:[KBaseUrl stringByAppendingPathComponent:dictM[@"url"]]];
     */
    
    YWCVideo *video = self.videos[indexPath.row];
    NSURL *url = [NSURL URLWithString:[KBaseUrl stringByAppendingPathComponent:video.url]];
    
    
    
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc]initWithContentURL:url];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
