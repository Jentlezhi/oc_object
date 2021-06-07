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
    
    [self interview07];
}

- (void)interview01{
    ///问题：以下代码是在主线程执行，会不会产生死锁？
    ///会产生死锁
    NSLog(@"任务1");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"任务2");
    });
    NSLog(@"任务3");
}

- (void)interview02{
    ///问题：以下代码是在主线程执行，会不会产生死锁？
    ///不会产生死锁: 执行顺序为：任务1 任务3 任务2
    NSLog(@"任务1");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"任务2");
    });
    NSLog(@"任务3");
}

- (void)interview03{
    ///问题：以下代码是在主线程执行，会不会产生死锁？
    ///会产生死锁
    NSLog(@"任务1");
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{///block0
        NSLog(@"任务2");
        dispatch_sync(queue, ^{///block1
            NSLog(@"任务3");
        });
        NSLog(@"任务4");
    });
    NSLog(@"任务5");
    ///任务1 -> 任务5 -> 任务2 -> 崩溃
}

- (void)interview04{
    ///问题：以下代码是在主线程执行，会不会产生死锁？
    ///不会产生死锁
    NSLog(@"任务1");
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue0 = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{///block0
        NSLog(@"任务2");
        dispatch_sync(queue0, ^{///block1
            NSLog(@"任务3");
        });
        NSLog(@"任务4");
    });
    NSLog(@"任务5");
    ///任务1 -> 任务5 -> 任务2 -> 任务3 -> 任务4
}

- (void)interview05{
    ///问题：以下代码是在主线程执行，会不会产生死锁？
    ///不会产生死锁
    NSLog(@"任务1");
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{///block0
        NSLog(@"任务2");
        dispatch_sync(queue, ^{///block1
            NSLog(@"任务3");
        });
        NSLog(@"任务4");
    });
    NSLog(@"任务5");
    ///任务1 -> 任务5 -> 任务2 -> 任务3 -> 任务4
}

- (void)interview06{
    
//    NSLog(@"------------主线程-----------------");
//    NSLog(@"1");
//    ///afterDelay：底层是定时器，添加到runLoop中，runLoop休眠前处理任务。
//    [self performSelector:@selector(printNumber2) withObject:nil afterDelay:.0];/// 输出 1 3 2
//    NSLog(@"3");
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"1");
//        [self performSelector:@selector(printNumber2) withObject:nil];/// 输出 1 2 3
        ///这句代码的本质是往RunLoop中添加定时器，子线程默认没有开启RunLoop
        [self performSelector:@selector(printNumber2) withObject:nil afterDelay:.0];/// 输出 1 3
        NSLog(@"3");
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init]forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)printNumber2 {
    
    NSLog(@"2");
}

- (void)interview07 {
    ///
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1");
        //RunLoop
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }];
    [thread start];
    ///崩溃：[ViewController performSelector:onThread:withObject:waitUntilDone:modes:]: target thread exited while waiting for the perform'
    [self performSelector:@selector(printNumber2) onThread:thread withObject:nil waitUntilDone:YES];
}

@end
