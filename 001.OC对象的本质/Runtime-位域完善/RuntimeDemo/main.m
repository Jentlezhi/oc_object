//
//  main.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import <objc/objc-runtime.h>

void test(void);
void mateClass(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {

    }
    return 0;
}

void test() {
    Person *p = [[Person alloc] init];
    p.tall = YES;
    p.rich = NO;
    p.handsome = YES;
    NSLog(@"isTall:%d",p.isTall);
    NSLog(@"isRich:%d",p.isRich);
    NSLog(@"isHandsome:%d",p.isHandsome);
}

void mateClass(){
    
    Person *p = [[Person alloc] init];
    NSLog(@"[p class] = %@",[p class]);
    NSLog(@"[p class] = %p",[p class]);
    NSLog(@"[p MetaClass] = %@",objc_getMetaClass("Person"));
    NSLog(@"[p object_getClass] = %p",object_getClass([Person class]));
    NSLog(@"[p MetaClass] = %p",objc_getMetaClass("Person"));
}
