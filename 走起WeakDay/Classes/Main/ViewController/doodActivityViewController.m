//
//  doodActivityViewController.m
//  走起WeakDay
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "doodActivityViewController.h"
#import "PullingRefreshTableView.h"
#import "goodTableViewCell.h"
#import <AFNetworking/AFHTTPSessionManager.h>



@interface doodActivityViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
//
{
    NSInteger _pageController;
}


@property(nonatomic, assign) BOOL refreshing;

@property(nonatomic, strong) PullingRefreshTableView *tableView;
@property(nonatomic, strong) NSMutableArray *goodArray;
@end

@implementation doodActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"竞选活动";
    [self showBackButton];
    
   
//    [self.tableView.tableFooterView = ]
    [self.view addSubview:self.tableView];

    //
    [self.tableView registerNib:[UINib nibWithNibName:@"goodTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    //
    [self.tableView launchRefreshing];
    [self loadData];
    
    
    
    
}

#pragma mark ------------------UITableviewDataScore;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    goodTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

#pragma mark delegate
//点击方法；
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) pullingDelegate:self];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 90;
    }
    return _tableView;
}


-(void)loadData{
    
    AFHTTPSessionManager *sessionMangrr = [[AFHTTPSessionManager alloc] init];
    sessionMangrr.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"text/html"];
    [sessionMangrr GET:[NSString stringWithFormat:@"%@&id=%ld",kGoodActivity,_pageController] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        YiralLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject;
        NSString *status = dict[@"status"];
        NSInteger code = [dict[@"code"] integerValue];
        if ([status isEqualToString:dict[@"success"]] && code == 0) {
            NSDictionary *dictSucce = dict[@"success"];
//            GoogActivityModel *model = [GoogActivityModel ]
//            [self.goodArray addObject:_model];
        }
        
        
        
//        YiralLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YiralLog(@"%@",error);
    }];
    
    
    
    [self.tableView tableViewDidFinishedLoading];
    self.tableView.reachedTheEnd = NO;
    [self.tableView reloadData];
    
}

-(NSMutableArray *)goodArray{
    if (_goodArray == nil) {
        self.goodArray = [NSMutableArray new];
    }
    return _goodArray;
}
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
    
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    
}

//上拉刷新开始调用
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    
}

//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    //创建一个NSDataFormatter显示刷新时间
    return [HWTools getSystemNowDay];
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
