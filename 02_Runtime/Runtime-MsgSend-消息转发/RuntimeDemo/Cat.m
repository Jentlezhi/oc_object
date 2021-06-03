//
//  Cat.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/30.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Cat.h"

@implementation Cat

- (void)test {
    
    NSLog(@"%s",__func__);
}

+ (void)classMethod {
    
    NSLog(@"这是类方法：%s",__func__);
}

- (void)classMethod {
    
    NSLog(@"这是对象方法：%s",__func__);
}

@end
