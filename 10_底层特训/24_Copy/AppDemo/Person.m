//
//  Person.m
//  AppDemo
//
//  Created by Jentle on 2022/3/14.
//

#import "Person.h"

@implementation Person

- (void)foo {
    NSLog(@"%s",__func__);
}

- (void)other {
    NSLog(@"%s",__func__);
}

- (id)copyWithZone:(NSZone *)zone {
    Person *p = [[self class] allocWithZone:zone];
    p.name = [self.name copy];
    p.address = [self.address copy];
    return p;
}

@end
