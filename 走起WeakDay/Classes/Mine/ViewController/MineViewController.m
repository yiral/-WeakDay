//
//  MineViewController.m
//  走起WeakDay
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "MineViewController.h"
#import <SDWebImage/SDImageCache.h>
#import <MessageUI/MessageUI.h>
#import "ProgressHUD.h"


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIButton *headImageViewbutton;
@property(nonatomic, strong) NSArray *imageArray;
@property(nonatomic, strong) NSMutableArray *titleArray;
@property(nonatomic, strong) UILabel *nameLable;


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageArray = @[@"icon_ele",@"icon_order",@"icon_ordered",@"icon_msg",@"icon_ac"];
    
    

    self.titleArray = [NSMutableArray arrayWithObjects:@"清除数据",@"用户反馈",@"给我评分",@"用分享给好友",@"当前版本1.0",nil];
    
    [self.view addSubview:self.tableView];
    
    [self setUpTableViewHeadView];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //每次图片出现的时候，重新计算图片缓存大小；
    SDImageCache *cache = [SDImageCache sharedImageCache];
    NSInteger catchSize = [cache getSize];
    NSString *cachstr = [NSString stringWithFormat:@"清除缓存大小 （%.02fM）",(float)catchSize/1024/1024];
    [self.titleArray replaceObjectAtIndex:0 withObject:cachstr];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

#pragma mark--------------------UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell== nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
//    if (indexPath.row == 0) {
//        
//        [self.titleArray insertObject:cachstr atIndex:0];
//        cell.detailTextLabel.text = cachstr;
//        NSLog(@"%lu",catchSize);
//    }


    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (int i = 0; i < 5; i ++) {
        if (indexPath.row == i) {
            cell.textLabel.text = self.titleArray[i];
            cell.imageView.image = [UIImage imageNamed:self.imageArray[i]];
        }
        
    }
    
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

#pragma mark--------------------UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            //清除；里面的图片；
            NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
            SDImageCache *cache = [SDImageCache sharedImageCache];
            [cache clearDisk];
            [self.titleArray replaceObjectAtIndex:0 withObject:@"清除缓存"];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];  
        }
            
            break;
        case 1:
        {
            [self sendEmail];
        }
            
            break;
        case 2:
        {
            //appsture 评分
            NSString *str = [NSString stringWithFormat:
                             
                             @"itms-apps://itunes.apple.com/app"];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }

                    break;
        case 3:
            [self share];
        
            break;
        case 4:
        {
            [ProgressHUD show:@"正在为您检测。。。"];
            [self performSelector:@selector(checkApp) withObject:nil afterDelay:2.0];
        }
            break;
            
        default:
            break;
    }
    
    
}

-(void)sendEmail{
    Class maiClass = NSClassFromString(@"MFMailComposeViewController");
    if (maiClass != nil) {
        if ([MFMailComposeViewController canSendMail]) {
            //初始化
            MFMailComposeViewController *ComposeView = [[MFMailComposeViewController alloc]init];
            //设置代理；
            ComposeView.mailComposeDelegate = self;
            //设置主题；
            [ComposeView setSubject:@"用户反馈"];
            //设置收件人；
            NSArray *receive = [NSArray arrayWithObjects:@"1209997913@qq.com", nil];
            [ComposeView setToRecipients:receive];
            //设置发送内容；
            NSString *text = @"请留下您宝贵的意见";
            [ComposeView setMessageBody:text isHTML:NO];
            [self presentViewController:ComposeView animated:YES completion:nil];
            
        }else{
            YiralLog(@"您的邮箱不支持邮件");
        }
    }else{
        YiralLog(@"目前设备不能发送邮件");
    }
   
    
}


-(void)share{
    
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200)];
    shareView.backgroundColor = [UIColor cyanColor];
    [window addSubview:shareView];
    
    //微博
    UIButton *weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboButton.frame = CGRectMake(20, 40, 35, 35);
    [weiboButton setImage:[UIImage imageNamed:@"ic_com_sina_weibo_sdk_login_button_with_frame_logo_focused"] forState:UIControlStateNormal];
    [shareView addSubview:weiboButton];
    
    //circle;
    UIButton *circleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    circleButton.frame = CGRectMake(100, 40, 35, 35);
    [circleButton setImage:[UIImage imageNamed:@"py_normal"] forState:UIControlStateNormal];
    [shareView addSubview:circleButton];
    
    //微信；
    UIButton *friendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    friendButton.frame = CGRectMake(150, 40, 35, 35);
    [friendButton setImage:[UIImage imageNamed:@"wx_normal"] forState:UIControlStateNormal];
    [shareView addSubview:friendButton];
    
    
    //remove;
    UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    removeButton.frame = CGRectMake(200, 100, 80, 40);
    [removeButton setTitle:@"取消" forState:UIControlStateNormal];
    [shareView addSubview:removeButton];

    
    
    
}
-(void)checkApp{
    [ProgressHUD showSuccess:@"已是最新版本"];
}
//邮件发送成功
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"取消");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"保存");
            break;
        case MFMailComposeResultSent:
            NSLog(@"发送");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"发送失败");
            [error localizedDescription];
            break;
            
        default:
            break;
    }
    
    
    
}

-(void)setUpTableViewHeadView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 210)];
    headView.backgroundColor = [UIColor colorWithRed:96/255.0 green:185/255.0 blue:191/255.0 alpha:1.0];

    [headView addSubview:self.headImageViewbutton];
    [headView addSubview:self.nameLable];
    self.tableView.tableHeaderView = headView;
    
    
    
}


-(UILabel *)nameLable{
    if (_nameLable == nil) {
        self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(180, 80, kScreenWidth - 200, 80)];
        self.nameLable.text = @"Hellow ,欢迎来到走起WeakDay";
        self.nameLable.textColor = [UIColor whiteColor];
        self.nameLable.numberOfLines = 0;
    }
    return _nameLable;
}

-(UIButton *)headImageViewbutton{
    if (_headImageViewbutton == nil) {
        self.headImageViewbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headImageViewbutton.frame = CGRectMake(20,40 , 130, 130);
        [self.headImageViewbutton setTitle:@"登陆/注册" forState:UIControlStateNormal];
        [self.headImageViewbutton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [self.headImageViewbutton setBackgroundColor:[UIColor whiteColor]];
        [self.headImageViewbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.headImageViewbutton.layer.cornerRadius = 65;
        self.headImageViewbutton.clipsToBounds = YES;
    }
         return _headImageViewbutton;
}
-(void)login{
    
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 44) style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;

    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
