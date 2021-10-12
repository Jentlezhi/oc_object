//
//  ViewController.m
//  MemoryManagement
//
//  Created by Jentle on 2019/12/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "JTTimer.h"

@interface ViewController ()

/// timer
@property(strong, nonatomic) dispatch_source_t timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Beign");
    [JTTimer executeTask:^{
        NSLog(@"***%@",[NSThread currentThread]);
    } delay:5.0 interval:1.0 repeats:YES async:NO];
}


@end
