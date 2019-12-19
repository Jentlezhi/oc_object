//
//  JTProxy.m
//  MemoryManagement
//
//  Created by Jentle on 2019/12/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "JTProxy.h"

@interface JTProxy ()

/// delegate
@property(weak, nonatomic) id delegate;

@end

@implementation JTProxy

+ (instancetype)proxyWithTarget:(id)target {
    
    JTProxy *proxy = [[JTProxy alloc] init];
    ///一定是弱引用
    proxy.delegate = target;
    return proxy;
}

///消息转发
- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    return _delegate;
}

@end
