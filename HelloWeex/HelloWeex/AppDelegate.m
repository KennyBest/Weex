//
//  AppDelegate.m
//  HelloWeex
//
//  Created by llj on 2016/12/23.
//  Copyright © 2016年 llj. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"
#import <WeexSDK/WeexSDK.h>
#import "LLEventModule.h"
#import "WXImgLoaderDefaultImpl.h"
#import "WXSelectComponent.h"

@interface AppDelegate ()
@property (strong, nonatomic) TestViewController *testViewController;

@end

@implementation AppDelegate


- (TestViewController *)testViewController {
    if (!_testViewController) {
        _testViewController = [[TestViewController alloc] init];
        
        //
        NSString *path = [NSString stringWithFormat:@"file://%@/kedeJS/kede_tabbar.js",[NSBundle mainBundle].bundlePath];
        
//        NSString *path = [NSString stringWithFormat:@"file://%@", [[NSBundle mainBundle] pathForResource:@"weex_list_sample" ofType:@"js"]];
        _testViewController.url = [NSURL URLWithString:path];
    }
    
    return _testViewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initWeexSDK];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.testViewController];
    self.window.rootViewController = nc;
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

// MARK: - 配置
- (void)initWeexSDK {
    [WXAppConfiguration setAppGroup:@"KedeApp"];
    [WXAppConfiguration setAppName:@"kedeDemo"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];
    
    // 初始化SDK环境
    [WXSDKEngine initSDKEnviroment];
    
    // 设置日志打印
    [WXLog setLogLevel:WXLogLevelError];
    
    [WXSDKEngine registerHandler:[[WXImgLoaderDefaultImpl alloc] init] withProtocol:@protocol(WXImgLoaderProtocol)];
    [WXSDKEngine registerHandler:[[LLEventModule alloc] init] withProtocol:@protocol(WXEventModuleProtocol)];
    [WXSDKEngine registerModule:@"event" withClass:[LLEventModule class]];
    [WXSDKEngine registerModule:@"select" withClass:NSClassFromString(@"WXSelectComponent")];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
