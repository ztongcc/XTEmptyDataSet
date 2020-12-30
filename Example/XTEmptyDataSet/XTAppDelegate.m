//
//  XTAppDelegate.m
//  XTEmptyDataSet
//
//  Created by ztongcc on 12/20/2020.
//  Copyright (c) 2020 ztongcc. All rights reserved.
//

#import "XTAppDelegate.h"
#import <UIView+XTEmptyDataSet.h>

@implementation XTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [UIView xt_setupGlobalEmptySetData:^(XTEmptyDataSetType type, XTDataSetConfig * _Nonnull config) {
        if (type == XTEmptyDataSetTypeLoading) {
            config.dataSetStyle = XTDataSetStyleIndicator;
        }else if (type == XTEmptyDataSetTypeError) {
            config.dataSetStyle = XTDataSetStyleTextAction;
            config.lableText = @"网络出错";
            config.buttonCornerRadius = 4;
            config.buttonBorderColor = [UIColor blueColor];
            config.buttonBorderWidth = 1;
            
            config.buttonNormalTitleColor = [UIColor blueColor];
            config.buttonTouchHandler = ^{
                NSLog(@"重试");
            };

        }else if (type == XTEmptyDataSetTypeNoData) {
            config.dataSetStyle = XTDataSetStyleTextAction;
            config.lableText = @"暂无数据";
        }
    }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
