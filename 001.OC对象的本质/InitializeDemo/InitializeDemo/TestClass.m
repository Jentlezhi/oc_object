//
//  TestClass.m
//  InitializeDemo
//
//  Created by Jentle on 2019/11/14.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass

+ (void)initialize {
    
    NSLog(@"%@-%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}

@end
