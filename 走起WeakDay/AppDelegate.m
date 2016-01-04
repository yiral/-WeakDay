//
//  AppDelegate.m
//  走起WeakDay
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    UITabBarController *tabbarC = [[UITabBarController alloc] init];
    //主页
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *mainNav = main.instantiateInitialViewController;
    mainNav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    mainNav.tabBarItem.image = [UIImage imageNamed:@"ft_home_selected_ic.png"];
    UIImage *mainImage = [UIImage imageNamed:@"ft_home_selected_ic.png"];
    //tablebar设置选中图片按照原始状态显示
    mainNav.tabBarItem.selectedImage = [mainImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    
    UIStoryboard *find = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
    UINavigationController *disNAV= find.instantiateInitialViewController;
    disNAV.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    disNAV.tabBarItem.image = [UIImage imageNamed:@"ft_found_selected_ic.png"];
    UIImage *disImage = [UIImage imageNamed:@"ft_found_selected_ic.png"];
    //tablebar设置选中图片按照原始状态显示
    disNAV.tabBarItem.selectedImage = [disImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    UIStoryboard *me = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    UINavigationController *meNAV = me.instantiateInitialViewController;
    meNAV.tabBarItem.image = [UIImage imageNamed:@"ft_person_selected_ic.png"];
    meNAV.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    UIImage *meImage = [UIImage imageNamed:@"ft_person_selected_ic.png"];
    //tablebar设置选中图片按照原始状态显示
    meNAV.tabBarItem.selectedImage = [meImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

    
    
    
    
    tabbarC.viewControllers = @[mainNav, disNAV, meNAV];
    tabbarC.tabBar.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
    self.window.rootViewController = tabbarC;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

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
