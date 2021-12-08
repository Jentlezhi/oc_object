//
//  Person.m
//  alloc&init
//
//  Created by Jentle on 2021/10/13.
//

#import "Person.h"

@implementation Person

+ (void)load {
    
    NSLog(@"%s",__func__);
}

+ (void)initialize {
    
    NSLog(@"%s",__func__);
}

+ (void)classMethod {
    
    NSLog(@"%s",__func__);
}

@end
