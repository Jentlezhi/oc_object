//
//  ViewController.m
//  MemoryManagement
//
//  Created by Jentle on 2019/12/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "NSTimerDelegate.h"
#import "JTProxy.h"

@interface ViewController ()

/// link
@property(strong, nonatomic) CADisplayLink *link;
/// timer
@property(strong, nonatomic) NSTimer *timer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///保证调用频率和屏幕的刷新频率一致，60FPS
//    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkTest)];
//    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
//   __weak typeof(self) weakSelf = self;
    ///在block总可以解决循环引用的问题
    ///因为block的特点：传弱指针就会弱引用
    ///上面传的是地址，只是个参数而已
    
    ////NSTimer
    ///解决方案：1 使用block
//    __weak typeof(self) weakSelf = self;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [weakSelf timerTest];
//    }];
    
    ///解决方案：2 中间代理：
//    __weak typeof(self) weakSelf = self;
//    NSTimerDelegate *delegate = NSTimerDelegate.new;
//    delegate.timerActionBlock = ^{
//        [weakSelf timerTest];
//    };
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    ///解决方案：3 中间代理：消息转发
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[JTProxy proxyWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
    
    
    self.link = [CADisplayLink displayLinkWithTarget:[JTProxy proxyWithTarget:self] selector:@selector(linkTest)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

- (void)linkTest {
    
    NSLog(@"%s",__func__);
}

- (void)timerTest {
    
    NSLog(@"%s",__func__);
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    [self.timer invalidate];
    [self.link invalidate];
}



@end
