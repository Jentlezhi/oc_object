//
//  Student.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/28.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Student.h"

@implementation Student

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"[self class] = %@",[self class]);//Student
        NSLog(@"[self superclass] = %@",[self superclass]);//Person
        
        NSLog(@"[super class] = %@",[super class]);//Student
        
        NSLog(@"[super superclass] = %@",[super superclass]);//Person
    }
    return self;
}

- (void)studentTest {
    

}

- (void)othetStudentTest {
    
    NSLog(@"%s",__func__);
}

@end
