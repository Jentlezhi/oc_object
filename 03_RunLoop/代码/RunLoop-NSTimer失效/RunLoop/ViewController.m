//
//  ViewController.m
//  RunLoop
//
//  Created by Jentle on 2019/10/2.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self timer];
    [self perform];
}

- (void)timer {
    
    static int count_ = 0;
    /*
     Creates and returns a new NSTimer object initialized with the specified block object. This timer needs to be scheduled on a run loop (via -[NSRunLoop addTimer:]) before it will fire.
     */
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            ///kCFRunLoopDefaultMode
            NSLog(@"currentRunLoop:%@",[NSRunLoop currentRunLoop]);
        });
        NSLog(@"%d",count_++);
    }];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    ///等价于NSRunLoopCommonModes
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
//    CFRunLoopAddObserver(<#CFRunLoopRef rl#>, <#CFRunLoopObserverRef observer#>, <#CFRunLoopMode mode#>)
}

- (void)scheduledTimer {
    static int count = 0;
    
    /* scheduledTimerWithTimeInterval:
     Creates and returns a new NSTimer object initialized with the specified block object and schedules it on the current run loop in the default mode
     */
    ///scheduledTimerWithTimeInterval 默认会把time调到到runloop中，并以NSDefaultRunLoopMode执行
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            ///kCFRunLoopDefaultMode
            NSLog(@"currentRunLoop:%@",[NSRunLoop currentRunLoop]);
        });
        NSLog(@"%d",count++);
    }];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    //或
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    ///当滑动scrollview时，导致block代码不再执行
//    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            ///kCFRunLoopDefaultMode
//            NSLog(@"currentRunLoop:%@",[NSRunLoop currentRunLoop]);
//        });
//        NSLog(@"%d",count++);
//    }];
}

- (void)perform {
    dispatch_queue_t queue = dispatch_queue_create(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        [self performSelector:@selector(test) withObject:nil afterDelay:1.f];
        //涉及到定时器的都和runloop有关系，
        [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)test {
    
    NSLog(@"%s",__func__);
}

@end
