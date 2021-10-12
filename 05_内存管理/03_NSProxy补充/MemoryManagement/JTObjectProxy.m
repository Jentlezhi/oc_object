//
//  JTObjectProxy.m
//  MemoryManagement
//
//  Created by Jentle on 2019/12/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "JTObjectProxy.h"

@interface JTObjectProxy ()

/// target
@property(weak, nonatomic) id target;

@end

@implementation JTObjectProxy

+ (instancetype)proxyWithTarget:(id)target {
    
    JTObjectProxy *proxy = [JTObjectProxy alloc];
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    return _target;
}


@end
