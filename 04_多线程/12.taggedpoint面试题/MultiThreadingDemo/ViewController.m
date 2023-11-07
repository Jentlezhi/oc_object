//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, copy) NSString *name;

@property(nonatomic, strong) NSLock *lock;

@end

@implementation ViewController

//宏定义
#define HXLog(_var) ({ NSString *name = @#_var; NSLog(@"变量名=%@，类型=%@， 地址=%p，引用计数=%d，值=%@", name, [_var class], _var,(int)[_var retainCount], _var); })


- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int index = 0; index < 1000; index++) {
        dispatch_async(queue, ^{
            NSString *name = @"jfdkllejqel23elqjfdkllejqel23elq";
            NSString *formatName = [NSString stringWithFormat:@"%@",name];
//            [self.lock lock];
//            self.name = [NSString stringWithFormat:@"%@",name];
//            [self.lock unlock];
        });
    }
    NSLog(@"---end");
}

- (void)setName:(NSString *)name {
    _name = name;
    NSLog(@"");
}

- (NSLock *)lock {
    if (!_lock) {
        _lock = [NSLock new];
    }
    return _lock;
}
@end
