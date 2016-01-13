//
//  ThemeViewController.m
//  走起WeakDay
//  推荐专题
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "ThemeViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "ThemeView.h"
@interface ThemeViewController ()

@property(nonatomic, strong) ThemeView *thmeView;
@end

@implementation ThemeViewController

-(void)loadView{
    [super loadView];
    self.thmeView = [[ThemeView alloc] initWithFrame:self.view.frame];
    [self.view addSubview: self.thmeView];
    [self getModel];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //提前创建好的类目；
    self.tabBarController.tabBar.hidden = YES;
    [self showBackButton];
    [self getModel];
}

-(void)getModel{
    AFHTTPSessionManager *SessionManager = [AFHTTPSessionManager manager];
    SessionManager .responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [SessionManager GET:[NSString stringWithFormat:@"%@&id=%@",kActivityTheme,self.themeID] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        YiralLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        YiralLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSString *status = dic[@"status"];
        NSInteger code = [dic[@"code"] integerValue];
        if ([status isEqualToString:@"success"] && code == 0) {
            NSDictionary *success = dic[@"success"];
            self.thmeView.dic = success;
            self.navigationItem.title = success[@"title"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    
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
