//
//  ViewController.m
//  MemoryManagement
//
//  Created by Jentle on 2019/12/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

/////解决方案1：
//@property(copy, atomic) NSString *name;

@property(copy, nonatomic) NSString *name;

@property(strong, nonatomic) NSLock *lock;

@end

@implementation ViewController

///set方法的实质:ARC底层转为MRC

//- (void)setName:(NSString *)name {
//
//    if (_name != name) {
//        [_name release];
//        _name = [name copy];
//    }
//}

- (NSLock *)lock {
    
    if (!_lock) {
        _lock = [[NSLock alloc] init];
    }
    return _lock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
//            NSString *a = @"abc";//Tagged Pointer技术，非普通对象
            NSString *b = @"abcdefghijklmn";//普通对象，多线程同时执行release的时候，会crash
//            self.name = [NSString stringWithFormat:a];
//            @synchronized (self) {
//                self.name = [NSString stringWithFormat:@"%@", b];
//            }
            [self.lock lock];
            self.name = [NSString stringWithFormat:@"%@", b];
            [self.lock unlock];

        });
    }
    NSLog(@"-%s ---end",__func__);
}


@end
