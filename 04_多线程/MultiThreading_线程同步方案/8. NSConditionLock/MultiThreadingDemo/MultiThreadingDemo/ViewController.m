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
@property(strong, nonatomic) NSConditionLock *conditionLock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ///condition默认为0
    self.conditionLock = [[NSConditionLock alloc] initWithCondition:1];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self test];
}

- (void)conditionLockAction {
    
    [[[NSThread alloc] initWithBlock:^{
        [self stepOne];
    }] start];
    
    [[[NSThread alloc] initWithBlock:^{
        [self stepTwo];
    }] start];
}

- (void)test {
    
    self.conditionLock = [[NSConditionLock alloc] initWithCondition:0];
    NSInteger total = 10;
    for (NSInteger index = 0; index < total; index++) {
        CGFloat random = arc4random()%10;
        [[[NSThread alloc] initWithBlock:^{
            
            [self.conditionLock lockWhenCondition:index];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(random * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (index == total-1) {
                    NSLog(@"%ld - %f",(long)index,random);
                    NSLog(@"执行完毕");
                    [self.conditionLock unlock];
                }else{
                    NSLog(@"%ld - %f",(long)index,random);
                    [self.conditionLock unlockWithCondition:index+1];
                }
            });
        }] start];
    }
}

- (void)stepOne {
    
    sleep(2.f);
    NSLog(@"---stepOne:begin---");
    [self.conditionLock lockWhenCondition:1];
    NSLog(@"stepOne");
    [self.conditionLock unlockWithCondition:2];
    NSLog(@"---stepOne:end---");
}

- (void)stepTwo {
    
    NSLog(@"---stepTwo:begin---");
    [self.conditionLock lockWhenCondition:2];
    NSLog(@"stepTwo");
    [self.conditionLock unlock];
    NSLog(@"---stepTwo:end---");
}

@end
