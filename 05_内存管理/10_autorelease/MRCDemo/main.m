//
//  main.m
//  MRCDemo
//
//  Created by Jentle on 2019/12/21.
//  Copyright © 2019 Jentle. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "Person.h"

///是NSObject.mm中的公开方法，通过调用autorelease pool提供的printAll()方法打印所有的自动释放池内容。
extern void _objc_autoreleasePoolPrint(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p = [[[Person alloc] init] autorelease];
        @autoreleasepool {
            Person *p1 = [[[Person alloc] init] autorelease];
            Person *p2 = [[[Person alloc] init] autorelease];
            Person *p3 = [[[Person alloc] init] autorelease];
            _objc_autoreleasePoolPrint();
        }
        _objc_autoreleasePoolPrint();
    }
    _objc_autoreleasePoolPrint();
    return 0;
}


/*
 { __AtAutoreleasePool __autoreleasepool;
   Person *p = [[[Person alloc] init] autorelease];
 }
 */


/*
 struct __AtAutoreleasePool {
 
 ///构造函数
   __AtAutoreleasePool() {
    atautoreleasepoolobj = objc_autoreleasePoolPush();
 }
 ///析构函数
   ~__AtAutoreleasePool() {
     objc_autoreleasePoolPop(atautoreleasepoolobj);
 }
   void * atautoreleasepoolobj;
 };
 */
