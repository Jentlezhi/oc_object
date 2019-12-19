//
//  ViewController.m
//  MemoryManagement
//
//  Created by Jentle on 2019/12/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

/// timer
@property(strong, nonatomic) dispatch_source_t timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self funcParOnSubThread];
}

- (void)base {
    ///必须强引用timer
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"dispatch_timer");
    });
    dispatch_resume(timer);
    self.timer = timer;
}

- (void)funcParOnSubThread {
    
    ///必须强引用timer:
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_queue_create("timer", DISPATCH_QUEUE_SERIAL));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler_f(timer, timerAction);
    dispatch_resume(timer);
    self.timer = timer;
}

void timerAction(){
    
    NSLog(@"timerAction:%@",[NSThread currentThread]);
}

@end
