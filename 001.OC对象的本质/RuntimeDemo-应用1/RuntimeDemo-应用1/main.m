//
//  main.m
//  RuntimeDemo-应用1
//
//  Created by Jentle on 2019/12/4.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Car.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ///获取类对象
        Person *p = [[Person alloc] init];
        [p run];
        
        ///object_getClass获取isa的指向
        NSLog(@"%p - %p",object_getClass(p),[Person class]);
        NSLog(@"%p - %p",object_getClass([Person class]),[Person class]);
    }
    return 0;
}
