//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self queue_create_serial_async];
}

- (void)queue_create_serial_async {
    
    ///DISPATCH_QUEUE_SERIAL or a NULL attribute invoke blocks serially in FIFO order
    ///DISPATCH_QUEUE_CONCURRENT attribute may invoke blocks concurrently
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    ///子线程中：任务1执行完之后执行任务2
}

- (void)queue_create_serial_sync {
    
    ///DISPATCH_QUEUE_SERIAL or a NULL attribute invoke blocks serially in FIFO order
    ///DISPATCH_QUEUE_CONCURRENT attribute may invoke blocks concurrently
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    ///主线程中：任务1执行完之后执行任务2
}

- (void)queue_create_concurrent_async {
    
    ///DISPATCH_QUEUE_SERIAL or a NULL attribute invoke blocks serially in FIFO order
    ///DISPATCH_QUEUE_CONCURRENT attribute may invoke blocks concurrently
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    ///子线程中：任务1和任务2交替执行
}

- (void)queue_create_concurrent_sync {
    
    ///DISPATCH_QUEUE_SERIAL or a NULL attribute invoke blocks serially in FIFO order
    ///DISPATCH_QUEUE_CONCURRENT attribute may invoke blocks concurrently
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    ///主线程中：任务1执行完之后执行任务2，并发只在异步函数下才有效
}



- (void)gcd_main_queue_sync_crash {
    
    ///串行主队列:任务在主线程执行，主队列添加同步任务会死锁！！！
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
}

- (void)gcd_main_queue_async {
    
    ///串行主队列:任务在主线程执行，主队列添加同步任务会死锁！！！
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    ///主线程中：任务1执行完之后执行任务2
}

- (void)gcd_global_queue_async {
    ///全局并发队列:允许多个任务并发执行，并发在异步函数下才有效！！！
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    ///子线程中：任务1和任务2交替执行
}


- (void)gcd_global_queue_sync {
    ///全局并发队列:允许多个任务并发执行，并发在异步函数下才有效！！！
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    ///主线程中：任务1执行完之后任务2再执行
}


@end
