//
//  UIControl+Extension.m
//  RuntimeAPIDemo
//
//  Created by Jentle on 2019/12/6.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "UIControl+Extension.h"
#import <objc/runtime.h>

@implementation UIControl (Extension)

+ (void)load {
    
    Method m1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method m2 = class_getInstanceMethod(self, @selector(my_sendAction:to:forEvent:));
    method_exchangeImplementations(m1, m2);
}

- (void)my_sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event {
    
    if ([self isKindOfClass:[UIButton class]]) {
        ///方法的拦截
        NSLog(@"%s",__func__);
        ///调用系统原来的实现: 已交换方法
        [self my_sendAction:action to:target forEvent:event];
    }else{
       [self my_sendAction:action to:target forEvent:event];
    }
}

/*
 void method_exchangeImplementations(Method m1_gen, Method m2_gen)
 {
     IMP m1_imp;
     old_method *m1 = oldmethod(m1_gen);
     old_method *m2 = oldmethod(m2_gen);
     if (!m1  ||  !m2) return;

     if (ignoreSelector(m1->method_name)  ||  ignoreSelector(m2->method_name)) {
         // Ignored methods stay ignored. Now they're both ignored.
         m1->method_imp = (IMP)&_objc_ignored_method;
         m2->method_imp = (IMP)&_objc_ignored_method;
         return;
     }

     impLock.lock();
     m1_imp = m1->method_imp;
     m1->method_imp = m2->method_imp;
     m2->method_imp = m1_imp;
     impLock.unlock();
 }
 
 */

@end
