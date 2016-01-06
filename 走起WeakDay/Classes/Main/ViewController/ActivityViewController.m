//
//  ActivityViewController.m
//  走起WeakDay
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "ActivityViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "UIViewController+Comment.h"
#import "MBProgressHUD.h"
@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.title = @"活动详情";
    [self showBackButton];
    
//    [self getModelMarkcustum];
}
-(void)getModelMarkcustum{
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [mager GET:[NSString stringWithFormat:@"%@&id=%@",kActivityDetail,self.ActivityID] parameters:self progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
