//
//  TestViewController.m
//  HelloWeex
//
//  Created by llj on 2016/12/23.
//  Copyright © 2016年 llj. All rights reserved.
//

#import "TestViewController.h"
#import <WeexSDK/WXSDKInstance.h>

/**
 Weex 支持两种模式
 1. 整页加载
 2. 部分加载
 
 根据特定的路径加载weex view 然后将其添加到父容器内
 WXSDKInstance 提供了加载weex view的基本方法与回调
 
 Note:
 Weex仅提供渲染能力，也支持其它能力 例如网络 图片 URL路由， 如果想使用这些功能 需要自己实现它
 
 地址跳转：查看LLEventModule
 A - 创建自定义组件
 1. 自定义组件必须实现 WXModuleProtocol协议
 2. WX_EXPORT_METHOD宏必须添加 这是可被weex识别唯一的方式，参数为指明可以被JavaScript代码调用的这个组件的方法
 3. 协议里面weexInstance对象必须合成 即使用@synthize weexInstance，每一个组件绑定一个特定的weexInstance
 4. 组件方法默认都是在主线程中唤醒，所以不要放置耗时操作，如果想要在其它线程执行这个组件中全部方法，须实现- (NSThread *)targetExecuteThread，这种方式下 这个组件中任务将在这个targetExcuteThread中执行
 5. weex 参数可以是字符串或者字典
 6. 组件支持在回调中返回结果给JavaScript 回调的类型为WXModuleCallback， 参数可以是字符串或者字典
 B - 注册创建好的自定义组件
    通过WXSDKEngine中的`registerModule:withClass`方法注册
 
 WeexSDK 没有图片下载，导航操作功能 这些功能需要自己实现协议 ---> Handler extand
    实现过后需要使用 `registerHandler:withProtocol`来注册

 */

/**
 原生组件使用
 自定义原生组件后，需要注册才能使用`registerComponent: withClass` 第一个参数代表在we文件可使用的标签名
 
 原生组件生命周期
 
 // 利用特定的属性初始化组件
 - (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance
 
 // 组件布局完成回调
 - layoutDidFinish
 
 // 创建组件管理的view
 - loadView
 
 // 加载view之前
 - viewWillLoad
 
 // 加载完成之后
 - viewDidLoad
 
 // 将要释放的时候 在释放之前
 - viewWillUnload
 // 释放之后
 - viewDidUnload
 
 // 组件布局样式更改后
 - updateStyles:
 
 // 组件属性更改后
 - updateAttributes:
 - addEvent:
 - removeEvent:
 
 ——————————————————————————————————————
 可以在we文件中的template模块中使用在组件中声明的属性
 */

@interface TestViewController ()

@property (strong, nonatomic) WXSDKInstance *instance;
@property (strong, nonatomic) UIView *weexView;



@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"HelloWeex";
    
    [self configureWXSDKInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_instance destroyInstance];
}

- (void)configureWXSDKInstance {
    _instance = [[WXSDKInstance alloc] init];
    _instance.viewController = self;
    _instance.frame = self.view.frame;
    
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    
    _instance.onFailed = ^(NSError *error) {
        //
        NSLog(@"%@", error.localizedDescription);
    };
    
    _instance.renderFinish = ^(UIView *view) {
        NSLog(@"加载结束");
    };
    
    [_instance renderWithURL:self.url options:@{@"bundleUrl": [self.url absoluteString]} data:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
