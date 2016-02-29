//
//  SelectCityViewController.m
//  走起WeakDay
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "SelectCityViewController.h"

@interface SelectCityViewController ()

@end

@implementation SelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"切换城市";
    self.view.backgroundColor = [UIColor cyanColor];
    [self showBackButton];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:96/255.0 green:185/255.0 blue:191/255.0 alpha:1.0];
    
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
