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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.thread start];
}

- (MyThread *)thread {
    
    if (!_thread) {
        _thread = [[MyThread alloc] initWithBlock:^{
            [[NSThread currentThread] setName:@"com.bitauto.cxt"];
            NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
            ///如果Mode里没有任何Source0/Source1/Timer/Observer，RunLoop会立马退出
            [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
            [runLoop run];
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
/* 截自YYWebImageOperation.m
 
 /// Network thread entry point.
 + (void)_networkThreadMain:(id)object {
     @autoreleasepool {
         [[NSThread currentThread] setName:@"com.ibireme.webimage.request"];
         NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
         [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
         [runLoop run];
     }
 }

 /// Global image request network thread, used by NSURLConnection delegate.
 + (NSThread *)_networkThread {
     static NSThread *thread = nil;
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
         thread = [[NSThread alloc] initWithTarget:self selector:@selector(_networkThreadMain:) object:nil];
         if ([thread respondsToSelector:@selector(setQualityOfService:)]) {
             thread.qualityOfService = NSQualityOfServiceBackground;
         }
         [thread start];
     });
     return thread;
 }
 */
                        


@end
