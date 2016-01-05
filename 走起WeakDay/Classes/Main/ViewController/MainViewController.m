//
//  MainViewController.m
//  走起WeakDay
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import <AFHTTPSessionManager.h>
#import "MainModel.h"
@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//全部数据
@property(nonatomic,strong) NSMutableArray *listArray;
//推荐活动数据；
@property(nonatomic, strong) NSMutableArray *activityArrtay;
//推荐专题数据
@property(nonatomic, strong) NSMutableArray *themeArray;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:96.0/255.0f green:185.0/255.0f blue:191.0/255.0f alpha:1.0];
//    self.navigationItem.b
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:@"北京" style:UIBarButtonItemStylePlain target:self action:@selector(selectorCityAction:)];
    self.navigationItem.leftBarButtonItem = leftBar;
    leftBar.tintColor = [UIColor whiteColor];

    //right;
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] ]
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 14, 14);
    [rightBtn setImage:[UIImage imageNamed:@"btn_search.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(selectorText) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarButtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightbarButtn;
    
    
    //注册cell；
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self configTableViewHeadView];
    [self requestModel];


    
}
#pragma mark ---------dataSouer
//分区的数量；
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;
}
//每个分区里的行数；
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.activityArrtay.count;
    }else
        return self.themeArray.count;
}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *mainCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSMutableArray *array = self.listArray[indexPath.section];
    mainCell.mainModel =array[indexPath.row];
    
    return mainCell;
}

#pragma mark ----------delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 203;
}


//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 342;
//    }
//    return 0;
//    
//}
//自定义分区区头；
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 343)];
//    view.backgroundColor = [UIColor cyanColor];
//    self.tableView.tableHeaderView = view;
//    
//    return nil;
//}

//选择城市；
-(void)selectorCityAction:(UIBarButtonItem *)bar{
    
}

//
-(void)selectorText{
    
}

-(void)configTableViewHeadView{
    UIView *tableViewHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 343)];
    tableViewHeadView.backgroundColor = [UIColor cyanColor];
    self.tableView.tableHeaderView = tableViewHeadView;
}

-(void)requestModel{
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *url = @"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1";
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *resultDic = responseObject;
        NSString *status = resultDic[@"status"];
        NSInteger code = [resultDic[@"code"]floatValue];
        if ([status isEqualToString:@"success" ] && code == 0) {
            NSDictionary *dic = resultDic[@"success"];
            //推荐活动
            NSArray *acDataArray = dic[@"acData"];
            for (NSDictionary *dict in acDataArray) {
                MainModel *model = [[MainModel alloc] initWithGetCellDictionary:dict];
                [self.activityArrtay addObject:model];
      
            }
                      [self.listArray addObject:self.activityArrtay];
            //推荐专题
            NSArray *rcDataArray = dic[@"rcData"];
            for (NSDictionary *dict in rcDataArray) {
                MainModel *model = [[MainModel alloc] initWithGetCellDictionary:dict];
                [self.themeArray addObject:model];
             
            }
               [self.listArray addObject:self.themeArray];
            //刷新tableView
            [self.tableView reloadData];
            //广告
            NSArray *adDataArray = dic[@"adData"];
            NSString *cityName = dic[@"cityname"];
            self.navigationItem.leftBarButtonItem.title = cityName;
        }
        
        
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

    
}
#pragma mark--------------懒加载
-(NSMutableArray *)listArray{
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
        
    }
    return _listArray;
}

-(NSMutableArray *)activityArrtay{
    if (_activityArrtay == nil) {
        self.activityArrtay = [NSMutableArray new];
    }
    return _activityArrtay;
}
-(NSMutableArray *)themeArray{
    if (_themeArray == nil) {
        self.themeArray = [NSMutableArray new];
    }
    return _themeArray;
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
