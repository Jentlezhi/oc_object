//
//  Person.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/9/18.
//

#import "Person.h"

@implementation Person
- (void)test {
    NSLog(@"Person - test");
}
- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
