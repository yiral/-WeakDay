//
//  MainModel.h
//  走起WeakDay
//
//  Created by scjy on 16/1/5.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    RecommendTypeActivity = 1,
    RecommendTypeTheme
    
}RecommendType;

@interface MainModel : NSObject



//地址
@property(nonatomic, copy) NSString *address;
//首页大图
@property(nonatomic, copy) NSString *image_big;
//标题
@property(nonatomic, copy) NSString *tittle;
//价格；
@property(nonatomic, copy) NSString *price;
//经纬度；
@property(nonatomic, assign) CGFloat lat;
@property(nonatomic, assign) CGFloat lng;
//开始，结束。时间；
@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, copy) NSString *endTime;
//数量；
@property(nonatomic, copy) NSString *count;
//地址
@property(nonatomic, copy) NSString *activityID;
//风格；
@property(nonatomic, copy) NSString *type;

@property(nonatomic, copy) NSString *activityDiscription;

-(instancetype)initWithGetCellDictionary:(NSDictionary *)dic;

@end
