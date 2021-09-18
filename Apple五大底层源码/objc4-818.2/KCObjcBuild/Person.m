//
//  Person.m
//  KCObjcBuild
//
//  Created by Jentle on 2021/9/15.
//

#import "Person.h"

@implementation Person

- (instancetype)init {
    
    if (self = [super init]) {
        [self sayHello];
        [self test2];
    }
    return self;
}

- (void)sayHello {
    
    NSLog(@"%s",__func__);
}

- (void)test2 {
    
    NSLog(@"%s",__func__);
}

@end
