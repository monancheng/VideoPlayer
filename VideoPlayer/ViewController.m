//
//  ViewController.m
//  VideoPlayer
//
//  Created by 陌南城 on 16/9/7.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "YFModel.h"
#import "UIImageView+WebCache.h"
#import "YFPlayViewController.h"
#import "YFViewCell.h"

#define URLString (@"http://c.m.163.com/nc/video/home/0-10.html")
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tbView ;
@property (nonatomic,strong)YFModel *model;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Test";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self downloadData];
}
- (void)createTableView
{
    self.tbView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    [self.view addSubview:self.tbView];
}
- (void)downloadData
{
    
    __weak typeof(self) wSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        wSelf.model = [[YFModel alloc]initWithDictionary:responseObject error:nil];
        [wSelf performSelectorOnMainThread:@selector(refreshUI) withObject:nil waitUntilDone:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)refreshUI
{
    [self.tbView reloadData];
}
#pragma mark=========UITableVIewDelegate方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId =@"cellId";
    YFViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"YFViewCell" owner:nil options:nil].lastObject;
    }
    VideoListModel *subModel = self.model.videoList[indexPath.row];
    [cell.yImageView sd_setImageWithURL:[NSURL URLWithString:subModel.cover]];
    cell.titleLabel.text = subModel.title;
    cell.subTitleLabel.text = subModel.descriptions;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.videoList.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YFPlayViewController *yfPlay = [YFPlayViewController shareVideoController];
    
    yfPlay.video = self.model.videoList[indexPath.row];
    [self.navigationController pushViewController:yfPlay animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
