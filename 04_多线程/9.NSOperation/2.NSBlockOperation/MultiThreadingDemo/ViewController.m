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
    
    [self defautOperation];
}

- (void)defautOperation {
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务a-%s - %@",__func__,[NSThread currentThread]);
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"任务b-%s - %@",__func__,[NSThread currentThread]);
    }];
    [op start];
    //默认：主线程，只有将NSOperation放到一个NSOperationQueue中，才会异步执行操作[reason: '*** -[NSOperationQueue addOperation:]: operation is finished and cannot be enqueued'],加入到queue，就不要执行start了，添加进NSOperationQueue会自动执行
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:op];/*-[ViewController task] - <NSThread: 0x600003824380>{number = 6, name = (null)}*/
    
}

- (void)task {
    
    NSLog(@"%s - %@",__func__,[NSThread currentThread]);
}


@end
