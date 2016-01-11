//
//  hotActivityModel.m
//  走起WeakDay
//
//  Created by scjy on 16/1/11.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "hotActivityModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation hotActivityModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        
        self.img = dic[@"img"];
        self.acticityId = dic[@"id"];
    }
    return self;
}


-(void)setModel:(hotActivityModel *)model{
//    self.img 
}
@end
