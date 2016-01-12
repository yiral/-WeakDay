//
//  diccoverModel.h
//  走起WeakDay
//
//  Created by scjy on 16/1/12.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface diccoverModel : NSObject
@property(nonatomic, copy) NSString *activityId;
@property(nonatomic, copy) NSString *image;

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *type;


-(instancetype)initWithFrom:(NSDictionary *)dic;



@end
