//
//  TestClass+Y.m
//  InitializeDemo
//
//  Created by Jentle on 2019/11/14.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "TestClass+Y.h"


@implementation TestClass (Y)

+ (void)initialize {
    
    NSLog(@"%@-(Y)-%@",@"TestClass",NSStringFromSelector(_cmd));
}

@end
