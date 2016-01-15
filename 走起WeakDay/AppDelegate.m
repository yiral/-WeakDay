//
//  AppDelegate.m
//  走起WeakDay
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "WeiboSDK.h"

//#import "SendMessageToWeiboViewController.h"
@interface AppDelegate ()<WeiboSDKDelegate,WBHttpRequestDelegate>



@end

@implementation AppDelegate

@synthesize wbtoken;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:AppKey];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    self.tablebar = [[UITabBarController alloc] init];
    //主页
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *mainNav = main.instantiateInitialViewController;
    mainNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    mainNav.tabBarItem.image = [UIImage imageNamed:@"ft_home_normal_ic.png"];
    UIImage *mainImage = [UIImage imageNamed:@"ft_home_selected_ic.png"];
    //tablebar设置选中图片按照原始状态显示
    mainNav.tabBarItem.selectedImage = [mainImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
    UIStoryboard *find = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
    UINavigationController *disNAV= find.instantiateInitialViewController;
    disNAV.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    disNAV.tabBarItem.image = [UIImage imageNamed:@"ft_found_normal_ic.png"];
    UIImage *disImage = [UIImage imageNamed:@"ft_found_selected_ic.png"];
    //tablebar设置选中图片按照原始状态显示
    disNAV.tabBarItem.selectedImage = [disImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIStoryboard *me = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    UINavigationController *meNAV = me.instantiateInitialViewController;
    meNAV.tabBarItem.image = [UIImage imageNamed:@"ft_person_normal_ic.png"];
    meNAV.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    UIImage *meImage = [UIImage imageNamed:@"ft_person_selected_ic.png"];
    //tablebar设置选中图片按照原始状态显示
    meNAV.tabBarItem.selectedImage = [meImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.tablebar.viewControllers = @[mainNav, disNAV, meNAV];
    self.tablebar.tabBar.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = self.tablebar;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
   
}


//-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
//
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请求异常" message:[NSString stringWithFormat:@"%@",error] delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//    [alert show];
//    
//}


//返回请求加载的结果
//-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
//    NSString *title = nil;
//    UIAlertView *alert = nil;
//    title = @"收到网络回调";
//    alert = [[UIAlertView alloc] initWithTitle:title message:[NSString stringWithFormat:@"%@",result] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
//    
//}

-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"user1"];
}
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"user1"];
    
}




//- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
//    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
//        
//        
//        
//        WBMessageObject *message = [WBMessageObject message];
//        
//        //    message.text = @"测试通过WeiboSDK发送文字到微博!";
//        message.text = @"测试使用";
//        
//        WBSendMessageToWeiboRequest *request=[WBSendMessageToWeiboRequest requestWithMessage:message];
//        
//        request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
//                             @"Other_Info_1": [NSNumber numberWithInt:123],
//                             @"Other_Info_2": @[@"obj1", @"obj2"],
//                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//        [WeiboSDK sendRequest:request];
//
//    }
//}




//- (WBMessageObject *)messageToShare
//{
//    WBMessageObject *message = [WBMessageObject message];
//    
//    //    message.text = @"测试通过WeiboSDK发送文字到微博!";
//    message.text = @"测试使用";
//    return message;
//}



#pragma mark ---------- Share Weibo

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WeiboSDK handleOpenURL:url delegate:self];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
    
}
////微博分享
//- (void)getWeiBoShare{
//    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
//    
//    
//    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
//    authRequest.redirectURI = KRedirectURI;
//    authRequest.scope = @"all";
//    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToshare] authInfo:authRequest access_token:myDelegate.wbtoken];
//    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
//    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
//    [WeiboSDK sendRequest:request];
////    [self remove];
//}


//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    return [WeiboSDK handleOpenURL:url delegate:self];
//}
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return [WeiboSDK handleOpenURL:url delegate:self];
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
