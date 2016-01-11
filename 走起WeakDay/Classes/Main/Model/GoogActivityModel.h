//
//  GoogActivityModel.h
//  走起WeakDay
//
//  Created by scjy on 16/1/8.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoogActivityModel : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *age;
@property(nonatomic, copy) NSString *counts;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *acticityId;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *modelID;


-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
