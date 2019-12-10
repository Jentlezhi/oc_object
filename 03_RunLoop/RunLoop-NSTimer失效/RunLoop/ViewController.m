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
    [self timer];
}

- (void)timer {
    static int count = 0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            ///kCFRunLoopDefaultMode
            NSLog(@"currentRunLoop:%@",[NSRunLoop currentRunLoop]);
        });
        NSLog(@"%d",count++);
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            ///kCFRunLoopDefaultMode
//            NSLog(@"currentRunLoop:%@",[NSRunLoop currentRunLoop]);
//        });
//        NSLog(@"%d",count++);
//    }];
}

@end
