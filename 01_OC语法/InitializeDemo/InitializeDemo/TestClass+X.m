//
//  TestClass+X.m
//  InitializeDemo
//
//  Created by Jentle-Zhi on 2023/9/4.
//  Copyright © 2023 Jentle. All rights reserved.
//

#import "TestClass+X.h"

@implementation TestClass (X)

+ (void)initialize {

    NSLog(@"%@-(X)-%@",@"TestClass",NSStringFromSelector(_cmd));
}

@end
