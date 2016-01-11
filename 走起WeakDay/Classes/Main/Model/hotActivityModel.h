//
//  hotActivityModel.h
//  走起WeakDay
//
//  Created by scjy on 16/1/11.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hotActivityModel : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dic;


@property(nonatomic, copy) NSString *img;
@property(nonatomic, copy) NSString *acticityId;
@property(nonatomic, copy) NSString *countID;


@property(nonatomic, retain) hotActivityModel *model;


@end
