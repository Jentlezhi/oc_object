//
//  JTPermenantThread.m
//  RunLoop
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "JTPermenantThread.h"

@interface JTThread : NSThread

@end

@implementation JTThread

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

@end

@interface JTPermenantThread ()

/// innerThread
@property(strong, nonatomic) JTThread *innerThread;
/// shouldKeepRunning
@property(assign, nonatomic) BOOL shouldKeepRunning;

@end

@implementation JTPermenantThread

- (JTThread *)innerThread {
    
    if (!_innerThread) {
        
        self.shouldKeepRunning = YES;
        __weak typeof(self) weakSelf = self;
        _innerThread = [[JTThread alloc] initWithBlock:^{
            [[NSThread currentThread] setName:@"com.companyName.test"];
            NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
            [runLoop addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            while (weakSelf && weakSelf.shouldKeepRunning) {
                [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
    }
    return _innerThread;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.innerThread start];
    }
    return self;
}

- (void)executeTask:(JTThreadTask)task {
    
    if (!task && !self.innerThread) {return;}
    [self performSelector:@selector(__task:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}

- (void)stop {
    
    if (!self.innerThread) {return;}
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}


- (void)__task:(JTThreadTask)task {
    
    task();
}

- (void)__stop {
    
    self.shouldKeepRunning = NO;
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [self stop];
}


//- (void)test {
//    [[NSRunLoop currentRunLoop] run];
//    ///等价于
//    while (1) {
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    }
//}

@end
