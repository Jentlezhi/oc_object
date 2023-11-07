//
//  main.m
//  MRCDemo
//
//  Created by Jentle on 2019/12/21.
//  Copyright © 2019 Jentle. All rights reserved.
//  关闭自动内存管理

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Dog.h"

void base(void){
    
    Person *p = [[Person alloc] init];
    NSLog(@"p:%zd",p.retainCount);
    [p release];
//    NSLog(@"p:%zd",p.retainCount);
    
    {
        Person *p1 = [[[Person alloc] init] autorelease];
        NSLog(@"p1:%zd",p1.retainCount);
    }
    NSLog(@"%s-------------end",__func__);
}

void objcReference1(void){
    
    Dog *dog = [[Dog alloc] init];
    Person *p = [[Person alloc] init];
    [p setDog:dog];
    [p release];
}

void objcReference2(void){
    
    Dog *dog = [[Dog alloc] init];
    Person *p = [[Person alloc] init];
    [p setDog:dog];
    [dog release];
    [[p dog] run];
    [p release];
}

void objcReference3(void){
    
    Dog *dog1 = [[Dog alloc] init];
    Dog *dog2 = [[Dog alloc] init];
    Person *p = [[Person alloc] init];
    
    [p setDog:dog1];
    [p setDog:dog2];
    
    [dog1 release];
    [dog2 release];
    [p release];
}

void objcReference4(void){
    
    Dog *dog = [[Dog alloc] init];
    Person *p = [[Person alloc] init];
    [p setDog:dog];
    [dog release];
    [p setDog:dog];
    [[p dog] run];
    [p release];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        base();
    }
    return 0;
}
