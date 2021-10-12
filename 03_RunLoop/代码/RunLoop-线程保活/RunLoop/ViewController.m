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
//    [self test];
}

- (void)test {

    NSLog(@"%@",[NSRunLoop currentRunLoop]);
    [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    // 上面线程不死，这句话永远不会打印
    NSLog(@"-------$$$$");
}

- (MyThread *)thread {
    
    if (!_thread) {
        _thread = [[MyThread alloc] initWithBlock:^{
            [[NSThread currentThread] setName:@"com.jentle.test"];
            [self addRunLoopStatusObserve];
            NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
            ///如果Mode里没有任何Source0/Source1/Timer/Observer，RunLoop会立马退出
            [runLoop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
            [runLoop run];
        }];
    }
    return _thread;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self performSelector:@selector(task) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)task {
    
    NSLog(@"%s",__func__);
//    NSLog(@"%@",[NSRunLoop currentRunLoop]);
}

- (void)addRunLoopStatusObserve {
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler( kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"kCFRunLoopEntry");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"kCFRunLoopBeforeTimers");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"kCFRunLoopBeforeSources");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"kCFRunLoopBeforeWaiting");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"kCFRunLoopAfterWaiting");
                break;
            case kCFRunLoopExit:
                NSLog(@"kCFRunLoopExit");
                break;
            default:
                break;
        }
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
    CFRelease(observer);
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
