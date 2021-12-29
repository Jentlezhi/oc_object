//
//  Teacher.m
//  CommandLineDemo
//
//  Created by Jentle on 2021/12/8.
//

#import "Teacher.h"
#import <objc/message.h>

@implementation Teacher

+ (void)sayHappy {
    
    NSLog(@"sayHappy");
}

- (void)sayHappy {
    
    NSLog(@"sayHappy");
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    NSLog(@"%@",NSStringFromSelector(sel));
//    return [super resolveInstanceMethod:sel];
//}

/**
 * 处理对象方法
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"--resolveInstanceMethod--");
    if (sel == @selector(noImpInstanceMethod)) {
//        IMP imp  = class_getMethodImplementation(self, @selector(sayHappy));
//        Method method = class_getClassMethod(self, @selector(sayHappy));
//        const char *type = method_getTypeEncoding(method);
//        return class_addMethod(self, sel, imp, type);
    }
    return [super resolveInstanceMethod:sel];
}

/**
 * 处理类方法
 */
+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(noImpClassMethod)) {
//        Class cls = object_getClass(self);
//        IMP imp  = class_getMethodImplementation(cls, @selector(sayHappy));
//        Method method = class_getClassMethod(cls, @selector(sayHappy));
//        const char *type = method_getTypeEncoding(method);
//        class_addMethod(cls, sel, imp, type);
//        return YES;
        return YES;
    }
    return [super resolveClassMethod:sel];
}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(noImpClassMethod)) {
//        Class cls = object_getClass(self);
//        IMP imp  = class_getMethodImplementation(cls, @selector(sayHappy));
//        Method method = class_getClassMethod(cls, @selector(sayHappy));
//        const char *type = method_getTypeEncoding(method);
//        class_addMethod(cls, sel, imp, type);
//        return YES;
//    }
//    return [super resolveClassMethod:sel];
//}

//+ (id)forwardingTargetForSelector:(SEL)aSelector {
//    
//    NSLog(@"++forwardingTargetForSelector++");
//    return [super forwardingTargetForSelector:aSelector];
//}
//
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    
//    NSLog(@"--forwardingTargetForSelector--");
//    return [super forwardingTargetForSelector:aSelector];
//}
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    
//    if (![self respondsToSelector:aSelector]) {
//        NSMethodSignature *ms = [NSMethodSignature signatureWithObjCTypes:"v@:"];
//        return ms;
//    }
//    return [super methodSignatureForSelector:aSelector];
//    
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    
//    NSLog(@"forwardInvocation");
//}


@end
