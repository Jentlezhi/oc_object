//
//  Person.m
//  RuntimeDemo-LLVM
//
//  Created by Jentle on 2019/12/3.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person.h"
#import "Test.h"

@implementation Person


- (void)other {
    
    NSLog(@"%s",__func__);
}
- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(run)) {
        return nil;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(run)) {
        
        return [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    [anInvocation invokeWithTarget:[[Test alloc] init]];
}

@end
