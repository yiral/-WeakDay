//
//  ActivityViewController.m
//  走起WeakDay
//  活动详情
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "ActivityViewController.h"
//网络请求
#import <AFNetworking/AFHTTPSessionManager.h>
//引入头文件；
#import "UIViewController+Comment.h"
//第三方菊花
//#import "MBProgressHUD.h"

#import "ActivityScrollView.h"
@interface ActivityViewController ()

@property(nonatomic, copy) NSString *phoneNumber;

@property (strong, nonatomic) IBOutlet ActivityScrollView *ActivityDeliaView;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.title = @"活动详情";
    [self showBackButton];
    self.tabBarController.tabBar.hidden = YES;
    //去地图页面；
    [self.ActivityDeliaView.mapButton addTarget:self action:@selector(mapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //打电话；
    [self.ActivityDeliaView.makeCallButton addTarget:self action:@selector(makeCallButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [self getModelMarkcustum];
}
//打电话
-(void)makeCallButtonAction:(UIButton *)button{
    //程序内打电话，打完电话返回应用程序；
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_phoneNumber]]];
    
    //程序外打电话，打完电话不反会应用程序；
    
    UIWebView *cellPhoneNumberView = [[UIWebView alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_phoneNumber]]];
    [cellPhoneNumberView loadRequest:request];
    [self.view addSubview:cellPhoneNumberView];
    
}
//去地图页面
-(void)mapButtonAction:(UIButton *)button{
    
}

#pragma mark----------Custom Mothod
-(void)getModelMarkcustum{
    
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    mager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [mager GET:[NSString stringWithFormat:@"%@&id=%@",kActivityDetail,self.ActivityID] parameters:self progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"%@",downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //菊花的网络等待；
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSDictionary *dic = responseObject;
        NSString *status = dic[@"status"];
        NSInteger code = [dic[@"code"] integerValue];
        if ([status isEqualToString:@"success"] && code == 0) {
            NSDictionary *successDic = dic[@"success"];
            self.ActivityDeliaView.dict = successDic;
        }
        
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



@end
