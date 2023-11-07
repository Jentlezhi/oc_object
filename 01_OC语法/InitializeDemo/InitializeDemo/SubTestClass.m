//
//  SubTestClass.m
//  InitializeDemo
//
//  Created by Jentle on 2019/11/14.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "SubTestClass.h"

@implementation SubTestClass

//+ (void)initialize {
//    NSLog(@"%@-%@",@"SubTestClass",NSStringFromSelector(_cmd));
//}

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"[self class] = %@",[self class]);//[self class] = SubTestClass
        NSLog(@"[super class] = %@",[super class]);//[super class] = SubTestClass
        NSLog(@"[self superclass] = %@",[self superclass]);//[self superclass] = TestClass
        NSLog(@"[super superclass] = %@",[super superclass]);//[super superclass] = TestClass
    }
    return self;
}

@end
