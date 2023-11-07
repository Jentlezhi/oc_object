//
//  Person.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/12/3.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)print {
    
    NSLog(@"my name is %@",self.name);
}


/*
 * 处理方法未实现
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    if ([self respondsToSelector:aSelector]) {
        return [super methodSignatureForSelector:aSelector];
    }
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    void *returnValue = NULL;
    NSMethodSignature *methodSignature = [anInvocation methodSignature];
    NSString *selectorName = NSStringFromSelector(anInvocation.selector);
    NSInteger numberOfArguments = [methodSignature numberOfArguments];
    NSLog(@"找不到%@方法",NSStringFromSelector(anInvocation.selector));
}

@end
