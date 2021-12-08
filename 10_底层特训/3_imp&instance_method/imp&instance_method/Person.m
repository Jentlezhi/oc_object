//
//  Person.m
//  imp&instance_method
//
//  Created by Jentle on 2021/10/19.
//

#import "Person.h"

@implementation Person

- (void)instanceMethod {
    
    NSLog(@"%s",__func__);
}

+ (void)classMethod {
    
    NSLog(@"%s",__func__);
}

@end
