//
//  main.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Person *p = [[Person alloc] init];
        p.age = 10;
        NSLog(@"age:%d",p.age);
        p->_idCardNum = @"212222992999922183";
        NSLog(@"_idCardNum:%@",p->_idCardNum);
        NSLog(@"height:%f",p.height);
    }
    return 0;
}
