//
//  AppDelegate.m
//  YZL_DIYTabBar
//
//  Created by YZL on 16/3/7.
//  Copyright © 2016年 YZL. All rights reserved.
//

#import "AppDelegate.h"
#import "YZLTabBarController.h"
#import "Test1ViewController.h"
#import "Test2ViewController.h"
#import "Test3ViewController.h"
#import "Test4ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSArray *viewControllers = @[[Test1ViewController new], [Test2ViewController new],[Test3ViewController new], [Test4ViewController new]];
    NSArray *titles = @[@"首页",@"消息",@"发现",@"我"];
    NSArray *images = @[@"tabbar_home",@"tabbar_message_center",@"tabbar_discover",@"tabbar_profile"];
    NSArray *selectedImages = @[@"tabbar_home_selected",@"tabbar_message_center_selected",@"tabbar_discover_selected",@"tabbar_profile_selected"];
    YZLTabBarController *tab = [[YZLTabBarController alloc] initWithViewControllers:viewControllers titles:titles images:images selectedImages:selectedImages];
    //一定要先把isShowCenterButton设成yes，设置menuTitleArr，menuImgArr，centerButtonBackgroundImg，centerButtonImg才有用
    tab.isShowCenterButton = YES;
    //弹出菜单标题数组
    tab.menuTitleArr = @[@"摄像",@"签到",@"照片",@"更多"];
    //弹出菜单图片数组
    tab.menuImgArr = @[@"tabbar_compose_camera",@"tabbar_compose_idea",@"tabbar_compose_photo",@"tabbar_compose_more"];
    //中间按钮背景图
    tab.centerButtonBackgroundImg = @"tabbar_compose_button";
    //中间按钮图片
    tab.centerButtonImg = @"tabbar_compose_icon_add";
    //中间按钮被选择时背景图
    tab.centerButtonBackgroundSelectedImg = @"tabbar_compose_button_highlighted";
    //中间按钮被选择时图片
    tab.centerButtonSelectedImg = @"tabbar_compose_icon_add_highlighted";
    //可选 默认字体颜色为黑色
//    tab.menuTitleColor = [UIColor blueColor];
    self.window.rootViewController = tab;
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
