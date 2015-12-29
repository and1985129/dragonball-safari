//
//  AppDelegate.m
//  dragonball-safari
//
//  Created by Wang, Ke on 12/23/15.
//  Copyright © 2015 Wang, Ke. All rights reserved.
//

#import "AppDelegate.h"
#import "BRTBeaconSDK.h"
#import "UserDefaultTool.h"
// define BRT_SDK_KEY 这里是我用于测试申请的key，请填写你申请的APP KEY，否则，将无法使用

#define BRT_SDK_KEY @"ad3964311ab74bf09edbcb21886ce97d"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    [BRTBeaconSDK registerApp:BRT_SDK_KEY onCompletion:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
    
    [UserDefaultTool initUserDefaultData];

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
