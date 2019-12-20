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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            NSString *a = @"abc";
            NSString *b = @"abcdefghijk";
            self.name = [NSString stringWithFormat:b];
        });
    }
}


@end
