//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "MyThread.h"

@interface ViewController ()

@property(strong, nonatomic) MyThread *myThread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myThread = [[MyThread alloc] initWithBlock:^{
        @autoreleasepool {
           NSLog(@"%s",__func__);
//            [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
//            [[NSRunLoop currentRunLoop] run];
        }
    }];
    [self.myThread start];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // Thread 1: EXC_BAD_ACCESS (code=1, address=0x7000066a5100)
    [self performSelector:@selector(task) onThread:self.myThread withObject:nil waitUntilDone:YES];
}

- (void)task {
    
    NSLog(@"%s",__func__);
}



@end
