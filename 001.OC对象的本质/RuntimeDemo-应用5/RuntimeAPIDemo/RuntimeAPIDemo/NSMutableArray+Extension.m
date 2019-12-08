//
//  NSMutableArray+Extension.m
//  RuntimeAPIDemo
//
//  Created by Jentle on 2019/12/6.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Extension)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ///类簇：NSSrtring、NSArray、NSDictionary，真实类型是其他类型。
        Class cls = NSClassFromString(@"__NSArrayM");
        Method m1 = class_getInstanceMethod(cls, @selector(insertObject:atIndex:));
        Method m2 = class_getInstanceMethod(cls, @selector(my_insertObject:atIndex:));
        method_exchangeImplementations(m1, m2);
        
        Method m3 = class_getInstanceMethod(cls, @selector(objectAtIndex:));
        Method m4 = class_getInstanceMethod(cls, @selector(my_objectAtIndex:));
        method_exchangeImplementations(m3, m4);
    });
}

- (void)my_insertObject:(id)anObject atIndex:(NSUInteger)index {
    
    if (anObject == nil) {return;}
    [self my_insertObject:anObject atIndex:index];
}

- (id)my_objectAtIndex:(NSUInteger)index {
    
    if (self.count <= index) {
        return nil;
    }
    return [self my_objectAtIndex:index];
}

@end
