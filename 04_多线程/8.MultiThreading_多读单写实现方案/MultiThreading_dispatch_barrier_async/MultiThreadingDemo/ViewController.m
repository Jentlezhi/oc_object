//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//  多读单写：dispatch_barrier_async

#import "ViewController.h"
#import "pthread.h"

@interface ViewController ()

/// lock
@property(strong, nonatomic) dispatch_queue_t queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///dispatch_barrier_async只有在自定义并发队列才有效，其他情况相当于dispatch_async的作用
    self.queue = dispatch_queue_create("dispatch_barrier", DISPATCH_QUEUE_CONCURRENT);
    
    [self read];
    [self read];
    [self read];
    [self read];
    [self read];
    [self write];
    NSLog(@"其他任务");
    
//    for (int index = 0; index<10; index++) {
//        [self read];
//        [self read];
//        [self read];
//        [self read];
//        [self read];
//        [self write];
//    }
}

- (void)read {
    dispatch_async(self.queue, ^{
        sleep(2.f);
        NSLog(@"%s-%@",__func__,[NSThread currentThread]);
    });
}

- (void)write {
    dispatch_barrier_sync(self.queue, ^{
        sleep(3.f);
        NSLog(@"%s-%@",__func__,[NSThread currentThread]);
    });
}

@end
