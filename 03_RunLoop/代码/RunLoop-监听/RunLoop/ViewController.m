//
//  ViewController.m
//  RunLoop
//
//  Created by Jentle on 2019/10/2.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRunLoopObserve];

}


- (void)timer {
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSLog(@"timer block");
        /*
         (lldb) bt
         * thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 2.1
         * frame #0: 0x000000010105e643 RunLoop`__29-[ViewController viewDidLoad]_block_invoke(.block_descriptor=0x0000000101060088, timer=0x0000600002f98780) at ViewController.m:21:9
         frame #1: 0x000000010141d079 Foundation`__NSFireTimer + 83
         frame #2: 0x00000001022f85b4 CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__ + 20
         frame #3: 0x00000001022f81c2 CoreFoundation`__CFRunLoopDoTimer + 1026
         frame #4: 0x00000001022f7a2a CoreFoundation`__CFRunLoopDoTimers + 266
         frame #5: 0x00000001022f20cc CoreFoundation`__CFRunLoopRun + 2220
         frame #6: 0x00000001022f14d2 CoreFoundation`CFRunLoopRunSpecific + 626
         frame #7: 0x000000010a9352fe GraphicsServices`GSEventRunModal + 65
         frame #8: 0x0000000105107fc2 UIKitCore`UIApplicationMain + 140
         frame #9: 0x000000010105e760 RunLoop`main(argc=1, argv=0x00007ffeeeba0f78) at main.m:14:16
         frame #10: 0x0000000103c76541 libdyld.dylib`start + 1
         frame #11: 0x0000000103c76541 libdyld.dylib`start + 1
         (lldb)
         */
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    ///此处打断点，然后查看方法调用堆栈（或lldb指令bt 查看）
    NSLog(@"touchesBegan");
    [self timer];
    /*
     (lldb) bt
     * thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 2.1
     * frame #0: 0x000000010c57970d RunLoop`-[ViewController touchesBegan:withEvent:](self=0x00007fbcdbe0b030, _cmd="touchesBegan:withEvent:", touches=1 element, event=0x0000600003778480) at ViewController.m:24:5
     frame #1: 0x0000000111e43001 UIKitCore`forwardTouchMethod + 353
     frame #2: 0x0000000111e42e8f UIKitCore`-[UIResponder touchesBegan:withEvent:] + 49
     frame #3: 0x0000000111e52240 UIKitCore`-[UIWindow _sendTouchesForEvent:] + 1869
     frame #4: 0x0000000111e53bca UIKitCore`-[UIWindow sendEvent:] + 4079
     frame #5: 0x0000000111e3230e UIKitCore`-[UIApplication sendEvent:] + 356
     frame #6: 0x0000000111f022b3 UIKitCore`__dispatchPreprocessedEventFromEventQueue + 3232
     frame #7: 0x0000000111f04bd9 UIKitCore`__handleEventQueueInternal + 5911
     ///// SOURCE0:
     frame #8: 0x000000010d812db1 CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 17
     frame #9: 0x000000010d812633 CoreFoundation`__CFRunLoopDoSources0 + 243
     frame #10: 0x000000010d80ccef CoreFoundation`__CFRunLoopRun + 1231
     frame #11: 0x000000010d80c4d2 CoreFoundation`CFRunLoopRunSpecific + 626
     frame #12: 0x0000000115f1f2fe GraphicsServices`GSEventRunModal + 65
     frame #13: 0x0000000111e17fc2 UIKitCore`UIApplicationMain + 140
     frame #14: 0x000000010c5797c0 RunLoop`main(argc=1, argv=0x00007ffee3685f78) at main.m:14:16
     frame #15: 0x000000010f191541 libdyld.dylib`start + 1
     frame #16: 0x000000010f191541 libdyld.dylib`start + 1
     (lldb)
     */
}

- (void)addRunLoopObserve {
    
//    CFRunLoopObserverContext context = {0, (__bridge void *)self, NULL, NULL};
//    CFRunLoopObserverRef observe = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, runLoopObserverCallBack, &context);
    CFRunLoopObserverRef observe = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        runLoopWithActivityType(activity);
    });
    //添加到主线程
    CFRunLoopAddObserver(CFRunLoopGetMain(), observe, kCFRunLoopCommonModes);
    CFRelease(observe);
}

void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    
    runLoopWithActivityType(activity);
}

void runLoopWithActivityType(CFRunLoopActivity activity){
    
    /*
     kCFRunLoopEntry = (1UL << 0),         // 进入RunLoop
     kCFRunLoopBeforeTimers = (1UL << 1),  // 即将开始Timer处理
     kCFRunLoopBeforeSources = (1UL << 2), // 即将开始Source处理
     kCFRunLoopBeforeWaiting = (1UL << 5), // 即将进入休眠
     kCFRunLoopAfterWaiting = (1UL << 6),  // 从休眠状态唤醒
     kCFRunLoopExit = (1UL << 7), //退出RunLoop
     kCFRunLoopAllActivities = 0x0FFFFFFFU
     */
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
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit");
            break;
        default:
            break;
    }
}


@end
