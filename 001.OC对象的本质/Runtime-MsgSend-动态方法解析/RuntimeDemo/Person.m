//
//  Person.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//


#import "Person.h"
#import <objc/runtime.h>

@interface Person ()


@end

@implementation Person

//- (void)personTest {
//    
//    NSLog(@"%s",__func__);
//}

struct method_t {
    
    SEL sel;
    char *types;
    IMP imp;
};

- (void)other {
    
    NSLog(@"%s",__func__);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    if (sel == @selector(personTest)) {
        ///方案一
//        struct method_t *otherMethod = (struct method_t *)class_getInstanceMethod(self, @selector(other));
//        ///动态添加方法
//        class_addMethod(self, sel, otherMethod->imp, otherMethod->types);
        ///方案二
        Method otherMethod = class_getInstanceMethod(self, @selector(other));
        class_addMethod(self, sel, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod));
        return YES;
    }
    NSLog(@"resolveInstanceMethod");
    return [super resolveInstanceMethod:sel];
}

@end
