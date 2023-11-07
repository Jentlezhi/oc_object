//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(strong, nonatomic) dispatch_source_t timerSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dispatch_source];
}

- (void)dispatch_source {
    
    // OC版本
    // 任务执行所指定的队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
 
    // 当前定时器源
    self.timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 任务执行开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    
    // 任务执行间隔时间
    uint64_t interval = 1.0 * NSEC_PER_SEC;
 
    // 给定时器源绑定开始时间、间隔时间以及容忍误差时间
    dispatch_source_set_timer(self.timerSource, start, interval, 0);
    
    // 给定时器源绑定任务
    dispatch_source_set_event_handler(self.timerSource, ^{
        // 内部最好使用weak/strong修饰的self, 防止循环引用
        NSLog(@"----self.timer---");
    });
    
    // 启动定时器源
    dispatch_resume(self.timerSource);
}



@end
