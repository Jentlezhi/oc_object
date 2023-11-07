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
    ///objc_msgSend((p, sel_registerName("personTest"));
    NSLog(@"@selector:%p - sel_registerName: %p",@selector(personTest),sel_registerName("personTest"));
    SEL sel = sel_registerName("personTest");
    [p personTest];
    
    ///类方法的方法调用
    ///objc_msgSend(objc_getClass("Person"), sel_registerName("initialize"));
    [Person initialize];
    
    
}
