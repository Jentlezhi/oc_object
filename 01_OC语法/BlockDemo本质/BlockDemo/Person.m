//
//  Person.m
//  BlockDemo
//
//  Created by Jentle on 2019/11/21.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)test {
    
    void(^block)(void) = ^{
        ///block是否会捕获self?
        NSLog(@"%p",self);
        ///仍然会捕获self,_age 实际调用为self->_age;
        NSLog(@"%d",_age);
    };
    block();
}

- (void)sleep {
    NSLog(@"sleep");
}

void eat(void){
    
    printf("eat");
}

@end
