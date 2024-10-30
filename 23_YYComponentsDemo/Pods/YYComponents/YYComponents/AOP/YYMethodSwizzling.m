//
//  YYMethodSwizzling.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/8/9.
//

#import "YYMethodSwizzling.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation YYMethodSwizzling

+ (void)yy_methodSwizzlingWithClass:(Class)cls
                             originalSEL:(SEL)originalSEL
                             swizzledSEL:(SEL)swizzledSEL {
    if (cls == nil) {
        NSCAssert(cls != nil, @"cls不能为空！");
        return;
    }
    Method oriMethod = class_getInstanceMethod(cls, originalSEL);
    Method swiMethod = class_getInstanceMethod(cls, swizzledSEL);
    if (!oriMethod) {
        class_addMethod(cls, originalSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
        method_setImplementation(swiMethod, imp_implementationWithBlock(^(id self, SEL _cmd){ }));
    }
    BOOL didAddMethod = class_addMethod(cls, originalSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else{
        method_exchangeImplementations(oriMethod, swiMethod);
    }
}
@end
