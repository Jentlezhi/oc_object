//
//  ViewController.m
//  MyProject
//
//  Created by Jentle on 2021/6/7.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>

@interface ViewController ()<FlutterStreamHandler>


@property (nonatomic, strong) FlutterEventSink eventSink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self toFlutter];
}

- (void)toFlutter {
    FlutterViewController *flutterVC = [[FlutterViewController alloc] init];
    
    //设置路由
    [flutterVC setInitialRoute:@"first"];
    
    NSString *channelName = @"com.flutter.guide.EventChannel";
        
    FlutterEventChannel *evenChannal = [FlutterEventChannel eventChannelWithName:channelName binaryMessenger:flutterVC];
    // 代理FlutterStreamHandler
    [evenChannal setStreamHandler:self];
    

    //push 或者 present
    [self presentViewController:flutterVC animated:YES completion:nil];
    
    
}

#pragma mark - FlutterStreamHandler
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)eventSink{
    self.eventSink = eventSink;
    if (eventSink) {
        //传递数据
        eventSink(@"我是native传来的数据");
    }
    return nil;
}

// flutter不再接收

- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    self.eventSink = nil;
    return nil;
}
 


@end
