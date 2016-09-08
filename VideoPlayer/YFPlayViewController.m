//
//  YFPlayViewController.m
//  TestVideo
//
//  Created by 陌南城 on 16/8/31.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "YFPlayViewController.h"
#import "FullViewController.h"
#import "FMGVideoPlayView.h"     // 播放器视图
#import "Video.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHight [UIScreen mainScreen].bounds.size.height

@interface YFPlayViewController ()<FMGVideoPlayViewDelegate>

/* 全屏控制器 */
@property (nonatomic, strong) FullViewController *fullVc;
@property (nonatomic, strong)UITextView *textView;


@end

@implementation YFPlayViewController
+ (instancetype) shareVideoController
{
    static YFPlayViewController *video = nil;
    static dispatch_once_t token ;
    if (video ==nil) {
        dispatch_once(&token, ^{
            video = [[YFPlayViewController alloc]init];
        });
    }
    return video;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (self.playView.urlString != _video.mp4_url) {
        [_playView setUrlString:_video.mp4_url];
        [_playView.player play];
        _playView.playOrPauseBtn.selected = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"bofang";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
    
    [self p_play];//播放
    [self setupView];//消息
    [self createScrollView];//聊天
    
}
- (void)createScrollView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.playView.frame), self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height-60-self.playView.frame.size.height-70)];
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.scrollView];
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(10, self.playView.frame.origin.y-60, self.scrollView.frame.size.width-20, self.scrollView.frame.size.height-20)];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.masksToBounds = YES;
    [self.scrollView addSubview:self.textView];
    
}


// 测试发送弹幕
- (void)setupView{
    self.testDanma = [[UITextField alloc] initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height-50, CGRectGetWidth(self.playView.frame)-60, 40)];
    self.testDanma.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_testDanma];
    
    
    
    self.sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.sendButton.frame = CGRectMake(CGRectGetMaxX(self.testDanma.frame), [UIScreen mainScreen].bounds.size.height-50, 40, 40);
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.sendButton addTarget:self action:@selector(sendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendButton];
    

}

- (void)sendButtonAction:(UIButton *)sender{
    
    
}

/**
 *  播放器
 */
- (void)p_play{
    self.playView = [FMGVideoPlayView videoPlayView];
    self.playView.delegate = self;
    _playView.index = 0;
    // 视频资源路径
    [_playView setUrlString:_video.mp4_url];
    // 播放器显示位置（竖屏时）
    _playView.frame = CGRectMake(0, 70, kScreenWidth, kScreenWidth/2);
    // 添加到当前控制器的view上
    [self.view addSubview:_playView];
    [_playView.player play];
    _playView.playOrPauseBtn.selected = YES;
    // 指定一个作为播放的控制器
    _playView.contrainerViewController = self;
    
}

#pragma mark - 懒加载代码
- (FullViewController *)fullVc
{
    if (_fullVc == nil) {
        _fullVc = [[FullViewController alloc] init];
    }
    return _fullVc;
}

- (void)leftBarButtonAction:(UIBarButtonItem *)sender{
    [_playView.player pause];
    [_playView.player setRate:0];
    _playView.playOrPauseBtn.selected = NO;
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 视频代理方法
- (void)videoplayViewSwitchOrientation:(BOOL)isFull
{
    if (isFull) {
        [self.navigationController presentViewController:self.fullVc animated:NO completion:^{
            [self.fullVc.view addSubview:self.playView];
            _playView.center = self.fullVc.view.center;
            
            [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                _playView.frame = self.fullVc.view.bounds;
            } completion:nil];
        }];
    } else {
        [self.fullVc dismissViewControllerAnimated:NO completion:^{
            [self.view addSubview:_playView];
            _playView.frame = CGRectMake(0,  70 , kScreenWidth, (kScreenWidth-20)/2);
        }];
    }
    
}
#pragma mark - 弹幕代理方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.testDanma resignFirstResponder];
    [self.textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
