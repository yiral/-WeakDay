//
//  LoginViewController.m
//  走起WeakDay
//
//  Created by scjy on 16/1/15.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "LoginViewController.h"
#import <BmobSDK/Bmob.h>
@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)addOneDate:(id)sender{
    //往GameScore表添加一条playerName为小明，分数为78的数据
    BmobObject *user = [BmobObject objectWithClassName:@"MenberUser"];
    
    [user setObject:@"yiral" forKey:@"user_Name"];
    [user setObject:@16 forKey:@"user_age"];
    [user setObject:@"女" forKey:@"user_Gander"];
    [user setObject:@"18860233231" forKey:@"user_Phone"];
    
    [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        YiralLog(@"注册成功");
    }];
    
}

- (IBAction)delegateOneData:(id)sender{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"MenberUser"];
    [bquery getObjectInBackgroundWithId:@"078d783dad" block:^(BmobObject *object, NSError *error){
        if (error) {
            //进行错误处理
        }
        else{
            if (object) {
                //异步删除object
                [object deleteInBackground];
            }
        }
    }];
    
}
- (IBAction)changeData:(id)sender {
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"MenberUser"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"078d783dad" block:^(BmobObject *object,NSError *error){
        //没有返回错误
        if (!error) {
            //对象存在
            if (object) {
                BmobObject *obj1 = [BmobObject objectWithoutDatatWithClassName:object.className objectId:object.objectId];
                //设置cheatMode为YES
                [obj1 setObject:@"yanzi" forKey:@"user_Name"];
                //异步更新数据
                [obj1 updateInBackground];
            }
        }else{
            //进行错误处理
        }
    }];
}

- (IBAction)insertData:(id)sender {
    
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"MenberUser"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"671d67acc3" block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                //得到playerName和cheatMode
                NSString *playerName = [object objectForKey:@"user_Name"];
                NSString *cellPhione = [object objectForKey:@"user_Phone"];
                NSLog(@"%@----%@",playerName,cellPhione);
            }
        }
    }];
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackButton];
}
-(void)backButtonAction:(UIButton *)button{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
