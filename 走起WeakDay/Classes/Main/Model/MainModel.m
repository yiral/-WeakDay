//
//  MainModel.m
//  走起WeakDay
//
//  Created by scjy on 16/1/5.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel
-(instancetype)initWithGetCellDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.type = dic[@"type"];
        //如果是推荐活动
        if ([self.type integerValue] == RecommendTypeActivity) {
            self.address = dic[@"address"];
            self.price = dic[@"price"];
            self.lat = [dic[@"lat"] floatValue];
            self.lng = [dic[@"lng"] floatValue];
            self.count = dic[@"counts"];
            self.startTime = dic[@"startTime"];
            self.endTime = dic[@"endTime"];
            self.title = dic[@"title"];

        }else{
            //如果是推荐专题；
            self.activityDiscription = dic[@"description"];
        }

        self.image_big = dic[@"image_big"];
        

        self.activityID = dic[@"id"];
        
    }
    return self;
}

@end
