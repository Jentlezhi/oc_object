//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property(assign, nonatomic) int num;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test3];
}

- (void)test1 {
    dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1");
    });
    dispatch_async(queue, ^{
        NSLog(@"2");
    });
    dispatch_sync(queue, ^{
        NSLog(@"3");
    });
    NSLog(@"0");
    dispatch_async(queue, ^{
        NSLog(@"7");
    });
    dispatch_async(queue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"8");
        });
    });
    dispatch_async(queue, ^{
        NSLog(@"9");
    });
}

- (void)test2 {
    
    while (self.num < 5) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.num++;
            NSLog(@"%d",self.num);
        });
        NSLog(@"-------------");
    }
    NSLog(@"end: %d",self.num);//>=5
}

- (void)test3 {
    
    for (int i = 0; i < 10000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.num++;
        });
    }
    NSLog(@"end: %d",self.num);// 0-9999之间，并且接进9999
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}



@end
