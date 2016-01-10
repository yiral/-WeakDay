//
//  HWTools.m
//  走起WeakDay
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "HWTools.h"

@implementation HWTools

#pragma mark --------------与时间相关的转换；
//通过时间戳；
//+(NSString *)getDateFromString:(NSString *)timeStamp{
//    NSTimeInterval time = [timeStamp doubleValue];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"yyyy.mm.dd"];
//    NSString *timeStr = [dateFormatter stringFromDate:date];
//    return timeStr;
//    
//}
+ (NSString *)getDateFromString:(NSString *)timestamp{
    
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *timeStr = [dateFormatter stringFromDate:date];
    return timeStr;
}


+(CGFloat)getTextHeightWithTest:(NSString *)text bigestSize:(CGSize)bigsize textFound:(CGFloat)found{
//    CGFloat textHeight ;
     CGRect textRect = [text boundingRectWithSize:bigsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:found]} context:nil];
    
    return textRect.size.height;
}

//
+(NSDate *)getSystemNowDay{
    //创建一个NSDataFormatter显示刷新时间
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [df stringFromDate:[NSDate date]];
    NSDate *date = [df dateFromString:dateStr];
    return date;
}

@end
