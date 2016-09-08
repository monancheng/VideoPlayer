//
//  YFViewCell.h
//  TestVideo
//
//  Created by 陌南城 on 16/9/1.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *yImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end
