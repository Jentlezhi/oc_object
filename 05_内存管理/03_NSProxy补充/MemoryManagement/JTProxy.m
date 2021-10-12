//
//  JTProxy.m
//  MemoryManagement
//
//  Created by Jentle on 2019/12/19.
//  Copyright © 2019 Jentle. All rights reserved.
//  专门用来做消息转发，执行效率高

#import "JTProxy.h"

@interface JTProxy ()

/// target
@property(weak, nonatomic) id target;

@end

@implementation JTProxy

+ (instancetype)proxyWithTarget:(id)target {
    
    JTProxy *proxy = [JTProxy alloc];
    proxy.target = target;
    return proxy;
}

- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    
    return [_target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    
    [invocation invokeWithTarget:_target];
}

@end
