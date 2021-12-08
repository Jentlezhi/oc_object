//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//  串行队列保证线程同步

#import "ViewController.h"

@interface ViewController ()

/// semaphore
@property(strong, nonatomic) dispatch_semaphore_t semaphore;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ///设置最大并发数量：设置为1可以保证线程同步
    self.semaphore = dispatch_semaphore_create(1);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self operation];
}

- (void)operation {
    for (NSInteger index = 0; index < 3; index++) {
        [[[NSThread alloc] initWithBlock:^{
            //返回值：P 操作成功，即对 semaphore.count 成功减 1，返回值为 0
            //P 操作失败，即对 semaphore.count 没有任何影响，返回值为非 0
            long semaphoreWait = dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"semaphoreWait - %ld",semaphoreWait);
            sleep(3.0);
            NSLog(@"index:%ld - %@",(long)index,[NSThread currentThread]);
            dispatch_semaphore_signal(self.semaphore);
        }] start];
    }
}


@end
