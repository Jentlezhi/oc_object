//
//  ViewController.m
//  RunLoop
//
//  Created by Jentle on 2019/10/2.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "JTPermenantThread.h"


@interface ViewController ()

/// 子线程
@property(strong, nonatomic) JTPermenantThread *thread;


@end

@implementation ViewController

- (JTPermenantThread *)thread {
    
    if (!_thread) {
        _thread = JTPermenantThread.new;
    }
    return _thread;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.thread executeTask:^{
        NSLog(@"A");
    }];
    
    [self.thread executeTask:^{
        NSLog(@"B");
    }];
    
    [self.thread executeTask:^{
        NSLog(@"C");
    }];
    
    [self.thread executeTask:^{
        NSLog(@"D");
    }];
    
    [self.thread executeTask:^{
        NSLog(@"E");
    }];
}

@end
