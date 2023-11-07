//
//  Person.m
//  BlockDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)test {
    
    NSLog(@"%s",__func__);
    __weak typeof(self) weakSelf = self;
    self.block = ^{
//        [weakSelf sayHello];
        __strong typeof(weakSelf) strongSelf = weakSelf;
//        dispatch_async(dispatch_queue_create(0, 0), ^{
//            [NSThread sleepForTimeInterval:1];
////            [strongSelf sayHello];
//            NSLog(@"%@",weakSelf);
//        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf sayHello];
        });
        NSLog(@"block - end");
    };
    self.block();
}

- (void)sayHello {
    
    NSLog(@"%s",__func__);
}

- (void)dealloc {
    
    NSLog(@"%s",__func__);
}

@end
