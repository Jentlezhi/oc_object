//
//  RuntimeTool.m
//  method_swizzing
//
//  Created by Jentle on 2021/11/2.
//

#import "RuntimeTool.h"
#import <objc/runtime.h>

@implementation RuntimeTool

+ (void)methodSwizzlingWithClass:(Class)cls oriSel:(SEL)oriSel swizzledSel:(SEL)swizzledSel {
    
    Method m1 = class_getInstanceMethod(cls, oriSel);
    Method m2 = class_getInstanceMethod(cls, swizzledSel);
    method_exchangeImplementations(m1, m2);
}

+ (void)betterMethodSwizzlingWithClass:(Class)cls oriSel:(SEL)oriSel swizzledSel:(SEL)swizzledSel {
    
    Method m1 = class_getInstanceMethod(cls, oriSel);
    Method m2 = class_getInstanceMethod(cls, swizzledSel);
    
    //通过给SEL设置IMP来实现方法的交换，子类没有父类的方法，我们就给子类添加一个该方法
    /*
     SEL-IMP
     superMethod sel -> 
     */
    BOOL didAdd = class_addMethod(cls, oriSel, class_getMethodImplementation(cls, swizzledSel), method_getTypeEncoding(m2));
    if (didAdd) {
        //swizzledSel：要替换的sel
        //class_getMethodImplementation(cls, oriSel):给sel绑定的映射
        class_replaceMethod(cls, swizzledSel,class_getMethodImplementation(cls, oriSel), method_getTypeEncoding(m1));
    }else{
        method_exchangeImplementations(m1, m2);
    }
    
}

@end
