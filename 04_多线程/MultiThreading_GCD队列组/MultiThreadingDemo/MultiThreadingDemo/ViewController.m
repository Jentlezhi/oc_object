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
    
    [self gcd_group];
}

- (void)gcd_group {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("gcd_group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        [self taskOne];
    });
    dispatch_group_async(group, queue, ^{
        [self taskTwo];
    });
//    dispatch_group_notify(group, queue, ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self taskThree];
//        });
//    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self taskThree];
    });
}

- (void)taskOne {
    
    for (int index = 0; index < 5; index ++) {
        NSLog(@"task1 - %d - %@",index,[NSThread currentThread]);
    }
}

- (void)taskTwo {
    for (int index = 0; index < 5; index ++) {
        NSLog(@"task2 - %d - %@",index,[NSThread currentThread]);
    }
}

- (void)taskThree {
    for (int index = 0; index < 5; index ++) {
        NSLog(@"task3 - %d - %@",index,[NSThread currentThread]);
    }
}



@end
