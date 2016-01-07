//
//  ActivityScrollView.h
//  走起WeakDay
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityScrollView : UIView
//地址
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
//电话
@property (strong, nonatomic) IBOutlet UIButton *makeCallButton;

@property(nonatomic, strong) NSDictionary *dict;

@end
