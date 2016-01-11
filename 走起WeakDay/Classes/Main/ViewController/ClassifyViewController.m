//
//  ClassifyViewController.m
//  走起WeakDay
//  分类列表
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "ClassifyViewController.h"
#import "VOSegmentedControl.h"
#import "PullingRefreshTableView.h"
#import "goodTableViewCell.h"
#import "GoogActivityModel.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "ActivityViewController.h"



@interface ClassifyViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>

{
    NSInteger _page;
}

@property(nonatomic, assign) BOOL refreshing;
@property(nonatomic, strong) PullingRefreshTableView *tableView;
//用来负责展示
@property(nonatomic, strong) NSMutableArray *showDataArray;

@property(nonatomic, strong) NSMutableArray *showArray;

@property(nonatomic, strong) NSMutableArray *touristArray;
@property(nonatomic, strong) NSMutableArray *studyArray;
@property(nonatomic, strong) NSMutableArray *familyArray;

@property(nonatomic, strong) VOSegmentedControl *segementControll;


@end


@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"分类列表";
    [self showBackButton];
//    [self loadData];
    [self.tableView addSubview:self.segementControll];
    [self.view addSubview:self.tableView];
//    [];

    
    //第一次进入分类列表，请求全部的数据；
    [self getFourRequest];
    
    
    
    
    
}
#pragma mark-------------------dataScore
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    goodTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    GoogActivityModel *model = self.showDataArray[indexPath.row];
    
    cell.model = model;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showDataArray.count;
}

#pragma mark-------------------delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ActivityViewController *activityVC = [storyBoard instantiateViewControllerWithIdentifier:@"ActivityDetailVC"];
    [self.navigationController pushViewController:activityVC animated:nil];
    
    
}

#pragma mark -----------pullingTableViewDidStartRefreshing
//手指开始拖动方法；
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
    
}
//下拉刷新开始时调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
    
}

//开始刷新的时候掉用；
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _page = 1;
    self.refreshing = YES;
    [self performSelector:@selector(getFourRequest) withObject:nil afterDelay:1.0];
    
}

//上拉加载开始调用
-(void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    _page += 1;
    self.refreshing = NO;
    [self performSelector:@selector(getFourRequest) withObject:nil afterDelay:1.0];
    
}

//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    //创建一个NSDataFormatter显示刷新时间
    return [HWTools getSystemNowDay];
}


#pragma mark-------------------customMethod
-(void)getFourRequest{
    AFHTTPSessionManager *sessionMangrr = [[AFHTTPSessionManager alloc] init];
    sessionMangrr.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"text/html"];
    //typeid = 6,演出剧目
    [sessionMangrr GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@",classify,@(1),@(6)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        YiralLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        YiralLog(@"%@",responseObject);
        NSDictionary *dict = responseObject;
        NSString *status = dict[@"status"];
        NSInteger code = [dict[@"code"] integerValue];
        if ([status isEqualToString:@"success"] && code == 0) {
            NSDictionary *dictSucce = dict[@"success"];
            NSArray *acArray = dictSucce[@"acData"];

            for (NSDictionary *dic in acArray) {
                GoogActivityModel *model = [[GoogActivityModel alloc] initWithDictionary:dic];
                [self.showArray addObject:model];
            }
            
        }else{
            
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YiralLog(@"%@",error);
    }];
    //typeid = 23，景点场景；
    [sessionMangrr GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@",classify,@(1),@(23)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        YiralLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        YiralLog(@"%@",responseObject);
        NSDictionary *dict = responseObject;
        NSString *status = dict[@"status"];
        NSInteger code = [dict[@"code"] integerValue];
        if ([status isEqualToString:@"success"] && code == 0) {
            NSDictionary *dictSucce = dict[@"success"];
            NSArray *acArray = dictSucce[@"acData"];

            for (NSDictionary *dic in acArray) {
                GoogActivityModel *model = [[GoogActivityModel alloc] initWithDictionary:dic];
                [self.touristArray addObject:model];
            }
            
        }else{
            
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YiralLog(@"%@",error);
    }];

    //typeid = 22 学习益智；
    [sessionMangrr GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@",classify,@(1),@(22)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        YiralLog(@"%@",downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        YiralLog(@"%@",responseObject);
        NSDictionary *dict = responseObject;
        NSString *status = dict[@"status"];
        NSInteger code = [dict[@"code"] integerValue];
        if ([status isEqualToString:@"success"] && code == 0) {
            NSDictionary *dictSucce = dict[@"success"];
            NSArray *acArray = dictSucce[@"acData"];

            for (NSDictionary *dic in acArray) {
                GoogActivityModel *model = [[GoogActivityModel alloc] initWithDictionary:dic];
                [self.studyArray addObject:model];
            }
            
        }else{
            
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YiralLog(@"%@",error);
    }];

    //typeid = 21，
    [sessionMangrr GET:[NSString stringWithFormat:@"%@&page=%@&typeid=%@",classify,@(1),@(21)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        YiralLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        YiralLog(@"%@",responseObject);
        NSDictionary *dict = responseObject;
        NSString *status = dict[@"status"];
        NSInteger code = [dict[@"code"] integerValue];
        if ([status isEqualToString:@"success"] && code == 0) {
            NSDictionary *dictSucce = dict[@"success"];
            NSArray *acArray = dictSucce[@"acData"];

            for (NSDictionary *dic in acArray) {
                GoogActivityModel *model = [[GoogActivityModel alloc] initWithDictionary:dic];
                [self.familyArray addObject:model];
            }
            
        }else{
            
        }
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YiralLog(@"%@",error);
    }];
    //根据上一页的选择按钮，确定显示第几页数据；
    [self showPreviousSelectButton];

}

-(void)showPreviousSelectButton{
    if (self.showDataArray.count > 0) {
        [self.showDataArray removeAllObjects];
    }
    switch (self.classifyListType) {
        case classifyListTypeShowReportoire:
            self.showDataArray = self.showArray;
            break;
        case classifyListTypeTourisePlace:
            self.showDataArray = self.touristArray;
            break;
        case classifyListTypeStudyPUZ:
            self.showDataArray = self.studyArray;
            break;
        case classifyListTypeFamilyTravel:
            self.showDataArray = self.familyArray;
            break;
            
        default:
            break;
    }
    [self.tableView reloadData];
}



//匪类列表；


#pragma mark-------------------lazyLoad

-(VOSegmentedControl *)segementControll{
    
    if (_segementControll == nil) {
        self.segementControll = [[VOSegmentedControl alloc] initWithSegments:@[@{VOSegmentText : @"演出剧目"},@{VOSegmentText : @"景点场景"},@{VOSegmentText : @"学习益智"},@{VOSegmentText : @"亲子旅游"}]];
        
        _segementControll.contentStyle = VOContentStyleTextAlone;
        _segementControll.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
        _segementControll.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _segementControll.selectedBackgroundColor = _segementControll.backgroundColor;
        _segementControll.allowNoSelection = NO;
        _segementControll.frame = CGRectMake(0, 0, kScreenWidth, 40);
        _segementControll.indicatorThickness = 4;
        self.segementControll.selectedSegmentIndex = self.classifyListType ;
//        [self.view addSubview:self.segementControll];
//        //点击返回的是哪个按钮；
//        __block NSInteger selectIndex;
        [_segementControll setIndexChangeBlock:^(NSInteger index) {
            
            NSLog(@"1: block --> %@", @(index));
//            self.selectIndex = index;
        }];
//        self.classifyListType = selectIndex;
        
        [_segementControll addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];

                                                                                
    }
    return _segementControll;
}

-(PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-104) pullingDelegate:self];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        
}
    return _tableView;
}
-(NSMutableArray *)showDataArray{
    if (_showDataArray == nil) {
        self.showDataArray = [NSMutableArray new];
    }
    return _showDataArray;
}

-(NSMutableArray *)showArray{
    if (_showArray == nil) {
        self.showArray = [NSMutableArray new];
    }
    return _showArray;
}
-(NSMutableArray *)studyArray{
    if (_studyArray == nil) {
        self.studyArray = [NSMutableArray new];
    }
    return _studyArray;
}
-(NSMutableArray *)familyArray{
    if (_familyArray == nil) {
        self.familyArray = [NSMutableArray new];
    }
    return _familyArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentCtrlValuechange: (VOSegmentedControl *)segmentCtrl{
    NSLog(@"%@: value --> %@",@(segmentCtrl.tag), @(segmentCtrl.selectedSegmentIndex));
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
