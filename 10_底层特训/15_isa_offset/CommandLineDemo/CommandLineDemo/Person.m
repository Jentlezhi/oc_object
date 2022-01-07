//
//  Person.m
//  CommandLineDemo
//
//  Created by Jentle on 2022/1/6.
//

#import "Person.h"

@implementation Person

- (void)saySomething {
    
    NSLog(@"%s - self.name = %@",__func__,self.name);
}

@end
