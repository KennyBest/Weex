//
//  WXDatePickerComponent.m
//  HelloWeex
//
//  Created by lining on 2016/12/29.
//  Copyright © 2016年 llj. All rights reserved.
//

#import "WXDatePickerComponent.h"

@interface WXDatePickerComponent ()

@property (nonatomic, strong) UIDatePicker *dataPicker;

@end

@implementation WXDatePickerComponent

- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance {

    self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance];
    
    if (self) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        CGSize windowSize = window.rootViewController.view.frame.size;
        CGFloat pickerViewHeight = 200.0f;
        _dataPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, windowSize.width, pickerViewHeight)];
    }
    
    return self;
}

- (UIView *)loadView {
    return _dataPicker;
}

- (void)viewDidLoad {
    [_dataPicker setDate:[NSDate date] animated:YES];
}

// MARK: - 更新属性

- (void)updateAttributes:(NSDictionary *)attributes {

}

// MARK: - 更新样式
- (void)updateStyles:(NSDictionary *)styles {
    
}


@end
