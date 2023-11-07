//
//  Student.m
//  RuntimeDemo
//
//  Created by Jentle on 2021/6/4.
//

#import "Student.h"

@implementation Student

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"[self class] = %@",[self class]);//[self class] = Student
        NSLog(@"[super class] = %@",[super class]);//[super class] = Student
        NSLog(@"[self superclass] = %@",[self superclass]);//[self superclass] = Person
        NSLog(@"[super superclass] = %@",[super superclass]);//[super superclass] = Person
    }
    return self;
}

@end
