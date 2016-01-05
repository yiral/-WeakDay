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
#import <SDWebImage/UIImageView+WebCache.h>
@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//全部数据
@property(nonatomic,strong) NSMutableArray *listArray;
//推荐活动数据；
@property(nonatomic, strong) NSMutableArray *activityArrtay;
//推荐专题数据
@property(nonatomic, strong) NSMutableArray *themeArray;
@property(nonatomic, strong) NSMutableArray *adArray;
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


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 26;
    
}
//自定义分区区头；
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 343)];
//    view.backgroundColor = [UIColor cyanColor];
//    self.tableView.tableHeaderView = view;
//    
//    return nil;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UIImageView *SectionView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-160, 5,320 , 16)];

    if (section == 0) {
        
        SectionView.image = [UIImage imageNamed:@"home_recommed_ac"];

    }else{
        
        SectionView.image = [UIImage imageNamed:@"home_recommd_rc"];


    }
    [view addSubview:SectionView];
    
    
    return view;
}

//选择城市；
-(void)selectorCityAction:(UIBarButtonItem *)bar{
    
}

//
-(void)selectorText{
    
}

-(void)configTableViewHeadView{
    UIView *tableViewHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 343)];

    self.tableView.tableHeaderView = tableViewHeadView;
    
    UIScrollView *carousView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 186)];
    carousView.contentSize = CGSizeMake(self.adArray.count * [ UIScreen mainScreen ].bounds.size.width, 186);
    for (int i = 0; i < self.adArray.count; i ++) {
        UIImageView *images = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*i, 0, [UIScreen mainScreen].bounds.size.width, 186)];
        [images sd_setImageWithURL:[NSURL URLWithString:self.adArray[i]] placeholderImage:nil];
        [carousView addSubview:images];
        
        
    }
    [tableViewHeadView addSubview:carousView];
    for (int i = 0; i < 5; i ++) {
        UIButton *buttton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        buttton1.frame = CGRectMake(i * [UIScreen mainScreen].bounds.size.width/4, 186, [UIScreen mainScreen].bounds.size.width/4, [UIScreen mainScreen].bounds.size.width/4);
        NSString *imageStr = [NSString stringWithFormat:@"home_icon_%02d",i+1];
        [buttton1 setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        [buttton1 addTarget:self action:@selector(mainActivityButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [tableViewHeadView addSubview:buttton1];
    }
    
    
    //
    UIButton *buttton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    buttton2.frame = CGRectMake(0, 186+[UIScreen mainScreen].bounds.size.width/4, [UIScreen mainScreen].bounds.size.width/2, 343-186-[UIScreen mainScreen].bounds.size.width/4);
    NSString *imageStr = [NSString stringWithFormat:@"home_zhuanti"];
    [buttton2 setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [buttton2 addTarget:self action:@selector(goodActivityButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [tableViewHeadView addSubview:buttton2];
    
    
    UIButton *buttton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    buttton3.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, 186+[UIScreen mainScreen].bounds.size.width/4, [UIScreen mainScreen].bounds.size.width/2, 343-186-[UIScreen mainScreen].bounds.size.width/4);
    NSString *imageStri = [NSString stringWithFormat:@"home_huodong"];
    [buttton3 setImage:[UIImage imageNamed:imageStri] forState:UIControlStateNormal];
    [buttton3 addTarget:self action:@selector(mainActivityButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [tableViewHeadView addSubview:buttton3];




}
-(void)mainActivityButtonAction{
    
}
-(void)goodActivityButtonAction{
    
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
            for (NSDictionary *dic in adDataArray) {
                
                [self.adArray addObject:dic[@"url"]];
            }
            //重新刷新头部文件；
            [self configTableViewHeadView];
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
-(NSArray *)adArray{
    if (_adArray == nil) {
        self.adArray = [NSMutableArray new];
    }
    return _adArray;
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
