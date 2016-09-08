//
//  YFModel.h
//  TestVideo
//
//  Created by 陌南城 on 16/8/31.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "JSONModel.h"
#define FString @property (nonatomic,copy)NSString<Optional> *
#define FInteger @property (nonatomic,assign)NSInteger<Optional>
#define FNumber @property (nonatomic,strong)NSNumber *
#define FDictionary @property (nonatomic,strong)NSDictionary<Optional> *
#define FArray @property (nonatomic,strong)NSArray<Optional> *

@protocol VideoListModel;
@protocol VideoSidListModel;
@interface YFModel : JSONModel
FString videoHomeSid;
//FArray videoList;
//FArray videoSidList;
@property (nonatomic,strong)NSArray<Optional,VideoListModel> *videoList;
@property (nonatomic,strong)NSArray<Optional,VideoSidListModel> *videoSidList;

@end



@interface VideoListModel : JSONModel
FString cover;
FString descriptions;
FString m3u8_url;
FString m3u8Hd_url;
FString mp4_url;
FString mp4Hd_url;
FString topicSid;
FString vid;
FString title;
@end
@interface VideoSidListModel : JSONModel
FString imgsrc;
FString sid;
FString title;
@end




