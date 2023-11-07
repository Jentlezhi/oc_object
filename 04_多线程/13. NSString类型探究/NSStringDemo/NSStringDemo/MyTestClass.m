//
//  MyTestClass.m
//  NSStringDemo
//
//  Created by Jentle-Zhi on 2023/8/9.
//

#import "MyTestClass.h"

@implementation MyTestClass

- (void)dealloc {
    [super dealloc];
    NSLog(@"%s",__func__);
}

@end
