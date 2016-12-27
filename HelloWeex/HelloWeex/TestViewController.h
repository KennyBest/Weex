//
//  TestViewController.h
//  HelloWeex
//
//  Created by llj on 2016/12/23.
//  Copyright © 2016年 llj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SRWebSocket.h>

@interface TestViewController : UIViewController<SRWebSocketDelegate>

@property (strong, nonatomic) NSString *script;
@property (strong, nonatomic) NSURL *url;

@property (strong, nonatomic) SRWebSocket *hotReloadSocket;
@property (strong, nonatomic) NSString *source;

@end
