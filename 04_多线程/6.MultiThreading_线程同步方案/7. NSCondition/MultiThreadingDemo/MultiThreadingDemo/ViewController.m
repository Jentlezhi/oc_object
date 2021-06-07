//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
//#import <pthread.h>

@interface ViewController ()

/// condition
@property(strong, nonatomic) NSCondition *condition;
/// data
@property(strong, nonatomic) NSMutableArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.condition = [[NSCondition alloc] init];
    
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
    [self.condition lock];
    
    if (self.data.count == 0) {
        ///等待:
        /*
         线程等待，把这把锁放开，product可以拿到这把锁
         */
        NSLog(@"---消费等待---");
        [self.condition wait];
    }
    [self.data removeLastObject];
    NSLog(@"%s - %@ - %@",__func__,[NSThread currentThread],self.data);
    [self.condition unlock];
    NSLog(@"---消费完毕---");
}

- (void)product {
    
    NSLog(@"---生产---");
    [self.condition lock];
    [self.data addObject:@"Apple"];
    NSLog(@"%s - %@ - %@",__func__,[NSThread currentThread],self.data);
    ///唤醒
    [self.condition signal];
    [self.condition unlock];
    NSLog(@"---生产完毕---");
}


- (void)dealloc
{
    
}

- (NSMutableArray *)data {
    
    if (!_data) {
        _data = @[].mutableCopy;
    }
    return _data;
}

@end
