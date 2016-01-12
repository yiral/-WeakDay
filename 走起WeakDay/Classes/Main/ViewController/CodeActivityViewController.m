//
//  CodeActivityViewController.m
//  走起WeakDay
//  热门专题
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "CodeActivityViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "PullingRefreshTableView.h"
#import "hotActivityModel.h"
#import "hotTableViewCell.h"
#import "ThemeViewController.h"

@interface CodeActivityViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    NSInteger _page;
}

@property(nonatomic, assign) BOOL refreshing;
@property(nonatomic, retain) PullingRefreshTableView *tableView;
@property(nonatomic, retain) NSMutableArray *listArray;

@end

@implementation CodeActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self showBackButton];
    self.title = @"热门专题";
    self.tabBarController.tabBar.hidden = YES;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"hotTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //刷新数据；
    [self.tableView launchRefreshing];
    [self loadData];

}


#pragma mark-----------------delegate;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    static NSString *cell = @"identifier";
    hotTableViewCell *hotCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    hotActivityModel *model = self.listArray[indexPath.row];
    
    hotCell.model = model;
    
    return hotCell;
    
}
#pragma mark-----------------ScoreDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ThemeViewController *themeVC = [[ThemeViewController alloc] init];
    hotActivityModel *model = self.listArray[indexPath.row];
    
    themeVC.themeID = model.countID;
    
    [self.navigationController pushViewController:themeVC animated:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData{
    //完成加载
    [self.tableView tableViewDidFinishedLoading];
    self.tableView.reachedTheEnd = NO;
    
    AFHTTPSessionManager *sessionMangrr = [[AFHTTPSessionManager alloc] init];
    sessionMangrr.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"text/html"];
    [sessionMangrr GET:[NSString stringWithFormat:@"%@&page=%ld",HotActivity,_page] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        YiralLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        NSString *status = dict[@"status"];
        NSInteger code = [dict[@"code"] integerValue];

        if ([status isEqualToString:@"success"] && code == 0) {
            NSDictionary *dictSucce = dict[@"success"];
            NSArray *acArray = dictSucce[@"rcData"];
            if (self.refreshing) {
                //下拉刷新的时候需要移除数组中的元素；
                if (self.listArray.count > 0) {
                    [self.listArray removeAllObjects];
                }
            }
            
            for (NSDictionary *dic in acArray) {
                hotActivityModel *model = [[hotActivityModel alloc] initWithDictionary:dic];
                
                [self.listArray addObject:model];
            }
            [self.tableView reloadData];
            
        }else{
            //当出现错误的时候返回客户的提示信息；
            
            
        }
        
//                YiralLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YiralLog(@"%@",error);
    }];
   
    [self.tableView tableViewDidFinishedLoading];
    self.tableView.reachedTheEnd = NO;
    [self.tableView reloadData];
    
}
#pragma -------------pulling

//手指开始拖动方法；
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
    
}
//下拉刷新开始时调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
    
}

#pragma mark -----------pullingTableViewDidStartRefreshing
//开始刷新的时候掉用；
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _page = 1;
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    
}

//上拉加载开始调用
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    _page += 1;
    self.refreshing = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    
}
//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    //创建一个NSDataFormatter显示刷新时间
    return [HWTools getSystemNowDay];
}

-(PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) pullingDelegate:self];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 180;
        self.tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}
-(NSMutableArray *)listArray{
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }
    return _listArray;
}



@end
