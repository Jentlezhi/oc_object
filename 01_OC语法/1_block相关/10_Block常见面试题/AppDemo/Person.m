//
//  Person.m
//  AppDemo
//
//  Created by Jentle on 2022/3/17.
//

#import "Person.h"

@implementation Person

- (void)dealloc {
    
    NSLog(@"%s",__func__);
}

- (void (^)(void))block {
    
    NSLog(@"block get");
    return ^{
        NSLog(@"block 实现");
    };
}

@end
