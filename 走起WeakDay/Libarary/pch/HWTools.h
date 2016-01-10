//
//  HWTools.h
//  走起WeakDay
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWTools : NSObject

//+(NSString *)getDateFromString:(NSString *)timeStamp;
//个悲剧指定时间戳
+ (NSString *)getDateFromString:(NSString *)timestamp;
//根据文字最大显示宽高和文字返回宽高；

+(CGFloat)getTextHeightWithTest:(NSString *)text bigestSize:(CGSize)bigsize textFound:(CGFloat)found;
//获取系统当前时间；
+(NSDate *)getSystemNowDay;

@end
