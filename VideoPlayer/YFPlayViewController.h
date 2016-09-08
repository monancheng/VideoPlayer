//
//  YFPlayViewController.h
//  TestVideo
//
//  Created by 陌南城 on 16/8/31.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Video;
@class FullViewController;
@class FMGVideoPlayView;
@interface YFPlayViewController : UIViewController
@property (nonatomic, strong) Video *video;
@property (nonatomic, strong) FMGVideoPlayView *playView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UITextField * testDanma;
@property (nonatomic, strong) UIButton * sendButton;
@property (nonatomic, strong) UIButton * hiddenButton;
@property (nonatomic, strong) UIScrollView *scrollView;



+ (instancetype) shareVideoController;

@end
