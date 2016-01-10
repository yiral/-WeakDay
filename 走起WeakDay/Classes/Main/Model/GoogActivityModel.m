//
//  GoogActivityModel.m
//  走起WeakDay
//
//  Created by scjy on 16/1/8.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "GoogActivityModel.h"

@implementation GoogActivityModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.age = dic[@"age"];
        self.image = dic[@"image"];
        self.counts = dic[@"counts"];
        self.acticityId = dic[@"id"];
        self.address = dic[@"address"];
        self.type = dic[@"type"];
        self.price = dic[@"price"];
    }
    return self;
}

@end
