//
//  Student.m
//  method_swizzing
//
//  Created by Jentle on 2021/10/27.
//

#import "Student.h"

@implementation Student

- (instancetype)init {
    
    if (self = [super init]) {
        NSLog(@"%@",[self class]);
        NSLog(@"%@",[super class]);
    }
    return self;
}

@end
