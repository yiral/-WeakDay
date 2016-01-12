//
//  DiscoverViewController.m
//  走起WeakDay
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverTableViewCell.h"
#import "PullingRefreshTableView.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "ProgressHUD.h"
#import "diccoverModel.h"
#import "ActivityViewController.h"


@interface DiscoverViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
//@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, assign ) BOOL refreshing;
@property (strong, nonatomic) PullingRefreshTableView *tableView;
@property(nonatomic, retain) NSMutableArray *array;


@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view.
    self.title = @"发现";
    //注册cell；
    [self.tableView registerNib:[UINib nibWithNibName:@"DiscoverTableViewCell" bundle:nil] forCellReuseIdentifier:@"Discell"];
    
    [self showBackButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.tableView];
    [self.tableView launchRefreshing];
}

#pragma mark---------------------------解析数据
-(void)configData{
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [ProgressHUD show:@"拼命加载。。。。"];
    [sessionManager GET: [NSString stringWithFormat:@"%@",discovery ] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        YiralLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [ProgressHUD showSuccess:@"Ok"];
        NSDictionary *dict = responseObject;
        NSString *success = dict[@"status"];
        NSInteger code = [dict[@"code"] integerValue];
        if ([success isEqualToString:@"success"] && code== 0) {
            NSDictionary *successDic = dict[@"success"];
            NSArray *likeArray = successDic[@"like"];
            for (NSDictionary *dic in likeArray) {
                diccoverModel *model = [[diccoverModel alloc] initWithFrom:dic];
                
                [self.array addObject:model];
            }
            [self.tableView reloadData];
            [self.tableView tableViewDidFinishedLoading];
            self.tableView.reachedTheEnd = NO;

        }else{
            
        }
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
        [ProgressHUD dismiss];
    }];
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Discell" forIndexPath:indexPath];
    
    diccoverModel *model = self.array[indexPath.row];
    
    cell.model = model;

    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.view viewForFirstBaselineLayout];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark----------------delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ActivityViewController *activityVC = [storyBoard instantiateViewControllerWithIdentifier:@"ActivityDetailVC"] ;
    diccoverModel *model = self.array[indexPath.row];
    
    activityVC.ActivityID = model.activityId;
    [self.navigationController pushViewController:activityVC animated:NO];
    
    
}

#pragma mark----------------PullingRefreshTableView
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(configData) withObject:nil afterDelay:1.0];
}

//-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
//    
//    [self performSelector:@selector(configData) withObject:nil afterDelay:1.0];
//
//}

-(NSDate *)pullingTableViewRefreshingFinishedDate{
    return [HWTools getSystemNowDay];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

-(PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) pullingDelegate:self];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 128;
    }
    return _tableView;
}

-(NSMutableArray *)array{
    if (_array == nil) {
        self.array = [NSMutableArray new];
    }
    return _array;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
