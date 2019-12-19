//
//  ViewController.m
//  RunLoop
//
//  Created by Jentle on 2019/10/2.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self timer];
    NSLog(@"main RunLoop: %p",[NSRunLoop mainRunLoop]);
    ///每个线程对应一个runLoop
    [[[NSThread alloc] initWithBlock:^{
        NSLog(@"A: %p",[NSRunLoop currentRunLoop]);
    }] start];
    
    [[[NSThread alloc] initWithBlock:^{
        NSLog(@"B: %p",[NSRunLoop currentRunLoop]);
    }] start];
}


- (void)timer {
    
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSLog(@"timer block: %p",[NSRunLoop currentRunLoop]);
        
    }];
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchesBegan: %p",[NSRunLoop currentRunLoop]);
}


@end
