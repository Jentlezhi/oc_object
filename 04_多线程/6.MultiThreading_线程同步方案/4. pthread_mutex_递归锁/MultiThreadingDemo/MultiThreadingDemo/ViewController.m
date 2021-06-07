//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//  生产者消费者模式

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

/// ticketLock
@property(assign, nonatomic) pthread_mutex_t lock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    ///递归锁
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
//    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    pthread_mutex_init(&_lock, &attr);
    pthread_mutexattr_destroy(&attr);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self testThree];
}

- (void)testOne {
    
    pthread_mutex_lock(&_lock);
    NSLog(@"%s",__func__);
    [self testTwo];
    pthread_mutex_unlock(&_lock);
}

- (void)testTwo {
    
    pthread_mutex_lock(&_lock);
    NSLog(@"%s",__func__);
    pthread_mutex_unlock(&_lock);
}

- (void)testThree {
    ///递归
    pthread_mutex_lock(&_lock);
    NSLog(@"%s",__func__);
    static int count = 0;
    if (count < 10) {
        count++;
        [self testThree];
    }
    pthread_mutex_unlock(&_lock);
}

- (void)dealloc
{
    pthread_mutex_destroy(&_lock);
    pthread_mutex_destroy(&_lock);
}

@end
