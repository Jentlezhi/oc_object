//
//  Person.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person.h"



@interface Person ()
{
    double _cusHeight;
}

@end

@implementation Person

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cusHeight = 19.0;
    }
    return self;
}

///@synthesize自动合成getter和setter的实现
@synthesize height = _cusHeight;

@end
