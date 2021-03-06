//
//  NSMutableDictionary+Extension.m
//  RuntimeAPIDemo
//
//  Created by Jentle on 2019/12/8.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "NSMutableDictionary+Extension.h"
#import <objc/runtime.h>


@implementation NSMutableDictionary (Extension)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ///类簇：NSSrtring、NSArray、NSDictionary，真实类型是其他类型。
        Class cls = NSClassFromString(@"__NSDictionaryM");
        Method m1 = class_getInstanceMethod(cls, @selector(setObject:forKey:));
        Method m2 = class_getInstanceMethod(cls, @selector(my_setObject:forKey:));
        method_exchangeImplementations(m1, m2);
        
        Method m3 = class_getInstanceMethod(cls, @selector(objectForKey:));
        Method m4 = class_getInstanceMethod(cls, @selector(my_objectForKey:));
        method_exchangeImplementations(m3, m4);
        
        Class cls1 = NSClassFromString(@"__NSDictionaryI");
        Method m5 = class_getInstanceMethod(cls1, @selector(setObject:forKey:));
        Method m6 = class_getInstanceMethod(cls1, @selector(my_setObject:forKey:));
        method_exchangeImplementations(m5, m6);
        
        Method m7 = class_getInstanceMethod(cls, @selector(objectForKey:));
        Method m8 = class_getInstanceMethod(cls, @selector(my_objectForKey:));
        method_exchangeImplementations(m7, m8);
    });
}

- (void)my_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    if (anObject == nil) {
        NSLog(@"object == nil");
        return;
    }
    [self my_setObject:anObject forKey:aKey];
}

- (id)my_objectForKey:(id)aKey {
    
    if (aKey == nil) {
        return nil;
    }
    return [self my_objectForKey:aKey];
}


@end
