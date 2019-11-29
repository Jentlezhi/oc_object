//
//  main.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
#import "MJClassInfo.h"


void funCall(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        funCall();
    }
    return 0;
}

void funCall(void) {
    Person *p = [[Person alloc] init];
    [p personTest];
}
