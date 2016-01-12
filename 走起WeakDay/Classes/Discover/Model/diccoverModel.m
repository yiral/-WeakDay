//
//  diccoverModel.m
//  走起WeakDay
//
//  Created by scjy on 16/1/12.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "diccoverModel.h"

@implementation diccoverModel
-(instancetype)initWithFrom:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.activityId = dic[@"id"];
        self.title = dic[@"title"];
        self.image = dic[@"image"];
        self.type = dic[@"type"];
        
    }
    return self;
}
@end
