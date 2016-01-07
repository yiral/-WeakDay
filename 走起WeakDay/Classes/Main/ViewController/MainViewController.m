//
//  MainViewController.m
//  走起WeakDay
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "MainViewController.h"
//头文件
#import "MainTableViewCell.h"
//网络请求第三方插件；
#import <AFHTTPSessionManager.h>
#import "MainModel.h"
#import "SelectCityViewController.h"
//照片插件；
#import <SDWebImage/UIImageView+WebCache.h>
#import "SearchViewController.h"
#import "ActivityViewController.h"
#import "ThemeViewController.h"
#import "ClassifyViewController.h"
#import "doodActivityViewController.h"
#import "CodeActivityViewController.h"
@interface MainViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
//全部数据
@property(nonatomic,strong) NSMutableArray *listArray;
//推荐活动数据；
@property(nonatomic, strong) NSMutableArray *activityArrtay;
//推荐专题数据
@property(nonatomic, strong) NSMutableArray *themeArray;
//全部数据
@property(nonatomic, strong) NSMutableArray *adArray;
//轮播图的加载
@property(nonatomic, retain) UIScrollView *carouseView;
//圆点显示；
@property(nonatomic, strong) UIPageControl *pageControl;
//用于图片滚动播放；
@property(nonatomic, strong) NSTimer *timer;
//热门专题点击按钮
@property(nonatomic, strong) UIButton *button2;
//精选活动点击按钮；
@property(nonatomic, strong) UIButton *button3;

@end

@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:96.0/255.0f green:185.0/255.0f blue:191.0/255.0f alpha:1.0];
    //首页北京的点击按钮；
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:@"北京" style:UIBarButtonItemStylePlain target:self action:@selector(selectorCityAction:)];
    self.navigationItem.leftBarButtonItem = leftBar;
    leftBar.tintColor = [UIColor whiteColor];

    //搜索图片的点击按钮
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
    [self startTimer];


    
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
    if (indexPath.section == 0) {
        return 203;
    }else{
        return 186;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 26;
    
}


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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
         ActivityViewController *ACTIVITYvc = [mainStory instantiateViewControllerWithIdentifier:@"ActivityDetailVC"];
        MainModel *mainmodel = self.listArray[indexPath.section][indexPath.row];
        ACTIVITYvc.ActivityID = mainmodel.activityID;
        
        [self.navigationController pushViewController:ACTIVITYvc animated:YES];
    }else{
        ThemeViewController *theme = [[ThemeViewController alloc] init];
        [self.navigationController pushViewController:theme animated:YES];
        
    }
    
}
#pragma mark------------导航栏选择城市与搜索
//选择城市；
-(void)selectorCityAction:(UIBarButtonItem *)bar{
    SelectCityViewController *selects = [[SelectCityViewController alloc]init];
    [self.navigationController presentViewController:selects animated:YES completion:nil];
}

//搜索
-(void)selectorText{
    SearchViewController *search = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark------------自定义区头
-(void)configTableViewHeadView{
    UIView *tableViewHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , 343)];

    
    [tableViewHeadView addSubview:self.button2];
    [tableViewHeadView addSubview:self.button3];
    //轮播图；
    self.carouseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 186)];
    self.carouseView.contentSize = CGSizeMake(self.adArray.count * kScreenWidth, 186);
    //整屏滑动
    self.carouseView.pagingEnabled = YES;
    //滚动条不显示；
    self.carouseView.showsHorizontalScrollIndicator = NO;
    self.carouseView.delegate = self;
    [tableViewHeadView addSubview:self.carouseView];
    self.pageControl.numberOfPages = self.adArray.count;
    [tableViewHeadView addSubview:self.pageControl];
    
    
    for (int i = 0; i < self.adArray.count; i ++) {
        UIImageView *images = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*i, 0, [UIScreen mainScreen].bounds.size.width, 186)];
        
        
        [images sd_setImageWithURL:[NSURL URLWithString:self.adArray[i][@"url"]] placeholderImage:nil];
        [self.carouseView addSubview:images];
        images.userInteractionEnabled = YES;
        
        //添加点击方法；
        UIButton *touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        touchButton.frame = images.frame;
        touchButton.tag = 100 +i;
        [touchButton addTarget:self action:@selector(touchAdvertisment:) forControlEvents:UIControlEventTouchUpInside];
        [self.carouseView addSubview:touchButton];
        
    }
 
    for (int i = 0; i < 5; i ++) {
        UIButton *buttton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        buttton1.frame = CGRectMake(i * [UIScreen mainScreen].bounds.size.width/4, 186, [UIScreen mainScreen].bounds.size.width/4, [UIScreen mainScreen].bounds.size.width/4);
        NSString *imageStr = [NSString stringWithFormat:@"home_icon_%02d",i+1];
        [buttton1 setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        [buttton1 addTarget:self action:@selector(mainActivityButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [tableViewHeadView addSubview:buttton1];
    }
    
    
    //
    self.tableView.tableHeaderView = tableViewHeadView;



}
#pragma mark ----------自定义区头button点击方法
//分类列表
-(void)mainActivityButtonAction{
    ClassifyViewController *classify = [[ClassifyViewController alloc] init];
    [self.navigationController pushViewController:classify animated:YES];
    
}
//精选活动·；
-(void)goodActivityButtonAction{
    doodActivityViewController *doodActivity = [[doodActivityViewController alloc] init];
    [self.navigationController pushViewController:doodActivity animated:YES];
    
}
//热门专题
-(void)hotActivityButtonAction{
    CodeActivityViewController *codeActivity = [[CodeActivityViewController alloc] init];
    [self.navigationController pushViewController:codeActivity animated:YES];
}


#pragma mark ------------- 请求书数据
-(void)requestModel{
  
    NSString *url = kMainDtaList;
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        YiralLog(@"%lld",downloadProgress.totalUnitCount);
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
                NSDictionary *dict = @{@"url":dic[@"url"],@"type":dic[@"type"],@"id":dic[@"id"]};
                [self.adArray addObject:dict];
            }
            //重新刷新头部文件；
            [self configTableViewHeadView];
            NSString *cityName = dic[@"cityname"];
            self.navigationItem.leftBarButtonItem.title = cityName;
        }
        
        
//        YiralLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YiralLog(@"%@",error);
    }];

    
}

//g广告点击方法；
-(void)touchAdvertisment:(UIButton *)adButton{
    NSString *type = self.adArray[adButton.tag - 100][@"type"];
    if ([type integerValue] == 1) {
        UIStoryboard *MainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ActivityViewController *activity = [MainStoryBoard instantiateViewControllerWithIdentifier:@"ActivityDetailVC"];
        activity.ActivityID = self.adArray[adButton.tag - 100][@"id"];
        
        [self.navigationController pushViewController:activity animated:YES];
    }else{
        CodeActivityViewController *codeVC = [[CodeActivityViewController alloc] init];
        [self.navigationController pushViewController:codeVC animated:YES];
    }
    
    
}
#pragma mark------------轮播图；

-(void)startTimer{
    if (_timer != nil) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(rollAnimation) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
//每两秒执行一次，图片实现轮播；
-(void)rollAnimation{
    //把page当前页面加1；
    NSInteger rollPage = (self.pageControl.currentPage + 1)%self.adArray.count;


    self.pageControl.currentPage = rollPage;
    //计算出scroll应该滚动的x轴坐标；
    CGFloat  offset = rollPage *kScreenWidth;
    [self.carouseView setContentOffset:CGPointMake(offset, 0) animated:YES];

    
}


//当手动滑动scrollview的时候，定时器仍然在计算时间，可能我们刚滑动到下一页，定时器时间刚好有触发，导致当前页面停留不足两秒；
//解决方案：在scrollview开始移动的时候结束定时器；
//移动完毕开启定时器；

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self rollAnimation];
    //停止定时器时置为nil,重启定时器才能保持正常执行；
    self.timer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

//轮播图
-(void)selectorPageContent:(UIPageControl *)pageCont{
    //获取点击的页面；
    NSInteger pageWith = pageCont.currentPage;
    //获取页面宽度
    CGFloat offSet = self.carouseView.frame.size.width;
    //让Scrollview滚动到第几页；
    self.carouseView.contentOffset = CGPointMake(pageWith * offSet, 0);
    
    
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取scroll页面宽度；
    CGFloat pageWith = self.carouseView.frame.size.width;
    //或许scrollview的偏移量；
    CGPoint offSet = self.carouseView.contentOffset;
    //通过偏移量和页面宽度计算当前页数；
    NSInteger pageNumber = offSet.x/pageWith;
    self.pageControl.currentPage = pageNumber;
    
    
}





#pragma mark--------------懒加载
//-(UIScrollView *)carouseView{
//    if (_carouseView == nil) {
//
//    }
//    return _carouseView;
//}

-(UIPageControl *)pageControl{
    if (_pageControl == nil) {
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 156, kScreenWidth, 30)];
        
        self.pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
        [self.pageControl addTarget:self action:@selector(selectorPageContent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pageControl;
}

-(UIButton *)button2{
    
    if (_button2 == nil) {
    self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button2.frame = CGRectMake(0, 186+[UIScreen mainScreen].bounds.size.width/4, [UIScreen mainScreen].bounds.size.width/2, 343-186-[UIScreen mainScreen].bounds.size.width/4);
    NSString *imageStr = [NSString stringWithFormat:@"home_zhuanti"];
    [self.button2 setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [self.button2 addTarget:self action:@selector(goodActivityButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}
-(UIButton *)button3{
    if (_button3 == nil) {
    self.button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button3.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2, 186+kScreenWidth/4, [UIScreen mainScreen].bounds.size.width/2, 343-186-[UIScreen mainScreen].bounds.size.width/4);
    NSString *imageStri = [NSString stringWithFormat:@"home_huodong"];
    [self.button3 setImage:[UIImage imageNamed:imageStri] forState:UIControlStateNormal];
    [self.button3 addTarget:self action:@selector(hotActivityButtonAction) forControlEvents:UIControlEventTouchUpInside];
        }
    return _button3;
    
}

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
