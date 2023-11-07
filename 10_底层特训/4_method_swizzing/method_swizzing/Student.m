//
//  Student.m
//  method_swizzing
//
//  Created by Jentle on 2021/10/27.
//

#import "Student.h"
#import <objc/runtime.h>

@implementation Student

+ (void)load {
    
    Method m1 = class_getInstanceMethod([self class], @selector(studentInstanceMethod));
    Method m2 = class_getInstanceMethod([self class], @selector(personInstanceMethod));
    method_exchangeImplementations(m1, m2);
}

- (void)studentInstanceMethod {
    
    NSLog(@"%d",self.age);
}

- (instancetype)init {
    
    if (self = [super init]) {
        NSLog(@"%@",[self class]);
        NSLog(@"%@",[super class]);
    }
    return self;
}

@end
