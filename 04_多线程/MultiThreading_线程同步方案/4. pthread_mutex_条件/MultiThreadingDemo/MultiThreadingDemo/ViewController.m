//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

/// ticketLock
@property(assign, nonatomic) pthread_mutex_t mutex;
/// data
@property(strong, nonatomic) NSMutableArray *data;
/// 条件
@property(assign, nonatomic) pthread_cond_t cond;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    ///递归锁
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
//    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    pthread_mutex_init(&_mutex, &attr);
    pthread_mutexattr_destroy(&attr);
    
    ///初始化条件
    pthread_cond_init(&_cond, NULL);
    
    ///
//    [self.data addObject:@"Orange"];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self producer_consumer_problem];
}

- (void)producer_consumer_problem {
    
    [[[NSThread alloc] initWithBlock:^{
        [self consume];
    }] start];
    
    [[[NSThread alloc] initWithBlock:^{
        [self product];
    }] start];
}
- (void)consume {
    
    NSLog(@"---消费---");
    pthread_mutex_lock(&_mutex);
    
    if (self.data.count == 0) {
        ///等待:
        /*
         线程等待，把这把锁放开，product可以拿到这把锁
         */
        NSLog(@"---消费等待---");
        pthread_cond_wait(&_cond, &_mutex);
    }
    [self.data removeLastObject];
    NSLog(@"%s - %@ - %@",__func__,[NSThread currentThread],self.data);
    pthread_mutex_unlock(&_mutex);
    NSLog(@"---消费完毕---");
}

- (void)product {
    
    NSLog(@"---生产---");
    pthread_mutex_lock(&_mutex);
    [self.data addObject:@"Apple"];
    NSLog(@"%s - %@ - %@",__func__,[NSThread currentThread],self.data);
    ///唤醒
    pthread_cond_signal(&_cond);
    pthread_mutex_unlock(&_mutex);
    NSLog(@"---生产完毕---");
}


- (void)dealloc
{
    pthread_mutex_destroy(&_mutex);
    pthread_mutex_destroy(&_mutex);
    pthread_cond_destroy(&_cond);
}

- (NSMutableArray *)data {
    
    if (!_data) {
        _data = @[].mutableCopy;
    }
    return _data;
}

@end
