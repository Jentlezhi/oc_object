//
//  Person.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//


#import "Person.h"
#import <objc/runtime.h>
#import "Cat.h"

@interface Person ()


@end

@implementation Person

//- (void)test {
//    
//    NSLog(@"%s",__func__);
//}

//struct method_t {
//
//    SEL sel;
//    char *types;
//    IMP imp;
//};

- (void)other {
    
    NSLog(@"%s",__func__);
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(test)) {
        ///若返回nil,则调用methodSignatureForSelector
        return nil;
//        return [[Cat alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(test)) {
        return [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];
    }
    return [super methodSignatureForSelector:aSelector];
}

//anInvocation封装了一个方法调用，包括：方法调用者、方法名、方法参数
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
//    anInvocation.target = [[Cat alloc] init];
//    [anInvocation invoke];
    [anInvocation invokeWithTarget:[[Cat alloc] init]];
    
}


//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//
//    if (sel == @selector(personTest)) {
//        ///方案一
////        struct method_t *otherMethod = (struct method_t *)class_getInstanceMethod(self, @selector(other));
////        ///动态添加方法
////        class_addMethod(self, sel, otherMethod->imp, otherMethod->types);
//        ///方案二
//        Method otherMethod = class_getInstanceMethod(self, @selector(other));
//        class_addMethod(self, sel, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod));
//        return YES;
//    }
//    NSLog(@"resolveInstanceMethod");
//    return [super resolveInstanceMethod:sel];
//}

@end
