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
    
    ///类簇：NSSrtring、NSArray、NSDictionary，真实类型是其他类型。
    Method m1 = class_getInstanceMethod(self, @selector(insertObject:atIndex:));
    Method m2 = class_getInstanceMethod(self, @selector(my_insertObject:atIndex:));
    method_exchangeImplementations(m1, m2);
    
}

- (void)my_insertObject:(id)anObject atIndex:(NSUInteger)index {
    
    
    if (anObject == nil) {return;}
//    [self my_insertObject:anObject atIndex:index];
}

@end
