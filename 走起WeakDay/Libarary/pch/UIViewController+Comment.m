//
//  UIViewController+Comment.m
//  走起WeakDay
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "UIViewController+Comment.h"

@implementation UIViewController (Comment)

-(void)showBackButton{
    
    UIButton *backbtn = [UIButton buttonWithType: UIButtonTypeCustom];
    backbtn.frame = CGRectMake(0, 0, 44, 44);
    [backbtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

-(void)backButtonAction:(UIButton *)button{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
