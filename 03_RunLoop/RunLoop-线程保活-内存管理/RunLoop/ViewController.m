//
//  ViewController.m
//  RunLoop
//
//  Created by Jentle on 2019/10/2.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "MyThread.h"


@interface ViewController ()

/// 子线程
@property(strong, nonatomic) MyThread *thread;
/// shouldKeepRunning
@property(assign, nonatomic) BOOL shouldKeepRunning;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.thread start];
}

- (MyThread *)thread {
    
    if (!_thread) {
        __weak typeof(self) weakSelf = self;
        self.shouldKeepRunning = YES;
        _thread = [[MyThread alloc] initWithBlock:^{
            [[NSThread currentThread] setName:@"com.bitauto.cxt"];
            NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
            ///如果Mode里没有任何Source0/Source1/Timer/Observer，RunLoop会立马退出
            [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
            while (weakSelf.shouldKeepRunning) {
                ///坏内存访问
                NSLog(@"self = %@",weakSelf);
                [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
            NSLog(@"%@---end---",[NSThread currentThread]);
//            [runLoop run];
            /*
             If no input sources or timers are attached to the run loop, this method exits immediately; otherwise, it runs the receiver in the NSDefaultRunLoopMode by repeatedly invoking runMode:beforeDate:. In other words, this method effectively begins an infinite loop that processes data from the run loop’s input sources and timers.
             Manually removing all known input sources and timers from the run loop is not a guarantee that the run loop will exit. macOS can install and remove additional input sources as needed to process requests targeted at the receiver’s thread. Those sources could therefore prevent the run loop from exiting.
             If you want the run loop to terminate, you shouldn't use this method. Instead, use one of the other run methods and also check other arbitrary conditions of your own, in a loop. A simple example would be:
             BOOL shouldKeepRunning = YES; // global
             NSRunLoop *theRL = [NSRunLoop currentRunLoop];
             while (shouldKeepRunning && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);

             */
        }];
    }
    return _thread;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self performSelector:@selector(task) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)task {

    NSLog(@"%s - %@",__func__,[NSThread currentThread]);
}

- (void)stopRunLoop {
    
    ///waitUntilDone：为NO可能会造成坏内存访问,为NO时候不会等待NSLog(@"%s- self = %@",__func__,self);以及}结束，dealloc中的}一结束self就为空，会造成坏内存访问
    [self performSelector:@selector(stopThread) onThread:self.thread withObject:nil waitUntilDone:YES];
    NSLog(@"%s- self = %@",__func__,self);
}

- (void)stopThread {
    self.shouldKeepRunning = NO;
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s - %@",__func__,[NSThread currentThread]);
}
                        
- (void)dealloc {
    [self stopRunLoop];
    NSLog(@"%s- self = %@",__func__,self);
//    while (1) {}
}

@end
