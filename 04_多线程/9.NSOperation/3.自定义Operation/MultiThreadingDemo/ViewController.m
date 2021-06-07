//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "MyOperation.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self customOperation];
}

- (void)customOperation {
    
    MyOperation *myOperation = [[MyOperation alloc] init];
    [myOperation start];
    
}

- (void)task {
    
    NSLog(@"%s - %@",__func__,[NSThread currentThread]);
}


@end
