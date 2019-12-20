//
//  JTTimer.m
//  MemoryManagement
//
//  Created by Jentle on 2019/12/20.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "JTTimer.h"


static NSMutableDictionary *timers;

@interface JTTimer ()

/// timer
@property(strong, nonatomic) dispatch_source_t timer;

@end

@implementation JTTimer

+ (void)initialize {
    
    ///初始化创建字典
    timers = [[NSMutableDictionary alloc] init];
}

+ (NSString *)executeTask:(void(^)(void))task
              delay:(NSTimeInterval)delay
           interval:(NSTimeInterval)interval
            repeats:(BOOL)repeats
              async:(BOOL)async {
    
    if (!task) {return nil;}

    NSString *key = [NSString stringWithFormat:@"%lu",(unsigned long)timers.count];
    ///必须强引用timer
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), interval * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            dispatch_source_cancel(timer);
        }
    });
    dispatch_resume(timer);
    ///强引用timer
    [timers setValue:timer forKey:key];
    return key;
}

+ (void)cancelTask:(NSString *)timerIdentifier {
    
    if (timerIdentifier == nil || timerIdentifier.length == 0) {return;}
    
    dispatch_source_t source = [timers valueForKey:timerIdentifier];
    dispatch_source_cancel(source);
    [timers removeObjectForKey:timerIdentifier];
}

@end
