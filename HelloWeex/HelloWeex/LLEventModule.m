//
//  LLEventModule.m
//  HelloWeex
//
//  Created by llj on 2016/12/26.
//  Copyright © 2016年 llj. All rights reserved.
//

#import "LLEventModule.h"
#import <WeexSDK/WXBaseViewController.h>
#import "TestViewController.h"

@implementation LLEventModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(openURL:))

- (void)openURL:(NSString *)url {
    NSString *newURL = url;
    if ([url hasPrefix:@"//"]) {
        newURL = [NSString stringWithFormat:@"http:%@", url];
    } else if (![url hasPrefix:@"http"]) {
        newURL = [NSURL URLWithString:url relativeToURL:weexInstance.scriptURL].absoluteString;
    }
    
    TestViewController *vc = [[TestViewController alloc] init];
    vc.url = [NSURL URLWithString:newURL];
    
    [[weexInstance.viewController navigationController] pushViewController:vc animated:YES];
}

@end
