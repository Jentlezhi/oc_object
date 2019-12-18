//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//  多读单写：

#import "ViewController.h"
#import "pthread.h"

@interface ViewController ()

/// lock
@property(assign, nonatomic) pthread_rwlock_t lock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pthread_rwlock_init(&_lock, NULL);
    for (int i = 0; i < 10; i++) {
        [[[NSThread alloc] initWithBlock:^{
            [self read];
        }] start];
        
        [[[NSThread alloc] initWithBlock:^{
            [self write];
        }] start];
    }
    
}

- (void)read {
    pthread_rwlock_rdlock(&_lock);
    sleep(2.f);
    NSLog(@"%s",__func__);
    pthread_rwlock_unlock(&_lock);
}

- (void)write {
    pthread_rwlock_wrlock(&_lock);
    sleep(2.f);
    NSLog(@"%s",__func__);
    pthread_rwlock_unlock(&_lock);
}

- (void)dealloc {
    
    pthread_rwlock_destroy(&_lock);
}


@end
