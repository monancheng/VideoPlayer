//
//  YFModel.m
//  TestVideo
//
//  Created by 陌南城 on 16/8/31.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "YFModel.h"

@implementation YFModel

@end
@implementation VideoListModel

+(JSONKeyMapper *)keyMapper
{
    return  [[JSONKeyMapper alloc]initWithDictionary:@{@"descriptions":@"description"}];
}

@end

@implementation VideoSidListModel



@end
//return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"descriptions":@"description"}];