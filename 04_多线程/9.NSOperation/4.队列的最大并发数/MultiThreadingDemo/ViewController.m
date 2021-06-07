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
    
    [self maxConcurrent];
}

- (void)maxConcurrent {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    for (int i = 0; i < 10; i++) {
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            sleep(1.f);
            NSLog(@"%s - %@",__func__,[NSThread currentThread]);
        }];
        [queue addOperation:op];
    }
}


@end
