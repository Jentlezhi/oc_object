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
- (void)addRunLoopObserve {
    

    //    CFRunLoopObserverRef observe = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, runLoopObserverCallBack, NULL);
    CFRunLoopObserverRef observe = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        runLoopWithActivityType(activity);
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observe, kCFRunLoopCommonModes);
    CFRelease(observe);
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
        {
            CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
            NSLog(@"kCFRunLoopEntry - %@", mode);
            CFRelease(mode);
        }
            break;
        case kCFRunLoopExit:
        {
            CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
            NSLog(@"kCFRunLoopExit - %@", mode);
            CFRelease(mode);
        }
            break;
        default:
            break;
    }
}


@end
