//
//  main.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "MJClassInfo.h"
#import <objc/runtime.h>
#import <objc/message.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Person *p = [[Person alloc] init];
        [p test];
        NSLog(@"-------实例对象--------");
        BOOL pIsMemberOfClass = [p isMemberOfClass:[NSObject class]];//0
        BOOL pIsKindOfClass = [p isKindOfClass:[NSObject class]];//1
        NSLog(@"pIsMemberOfClass:%d",pIsMemberOfClass);
        NSLog(@"pIsKindOfClass:%d",pIsKindOfClass);
        NSLog(@"-------类对象--------");
        ///object_getClass(obj)返回类对象中的isa指针，即指向元类对象的指针；[obj class]返回的则是其本身。
        ///返回元类
        NSLog(@"%@-%p",object_getClass([Person class]),object_getClass([Person class]));
        ///返回类本身
        NSLog(@"[Person isMemberOfClass:object_getClass([Person class])]:%d",[Person isMemberOfClass:object_getClass([Person class])]);//1
        NSLog(@"[Person isKindOfClass:[Person class]]:%d",[Person isKindOfClass:[Person class]]);//0
        NSLog(@"[Person isKindOfClass:object_getClass([Person class])]:%d",[Person isKindOfClass:object_getClass([Person class])]);//1
        NSLog(@"[Person isKindOfClass:object_getClass([NSObject class])]:%d",[Person isKindOfClass:object_getClass([NSObject class])]);//1
        ///特殊：：：NSObject是基类，基类的元类对象的superClass指向基类的类对象
        NSLog(@"[Person isKindOfClass:[NSObject class]]:%d",[Person isKindOfClass:[NSObject class]]);//1
    }
    return 0;
}

//+ (BOOL)isMemberOfClass:(Class)cls {
//    return object_getClass((id)self) == cls;
//}
//
//- (BOOL)isMemberOfClass:(Class)cls {
//    return [self class] == cls;
//}
//
//+ (BOOL)isKindOfClass:(Class)cls {
//    for (Class tcls = object_getClass((id)self); tcls; tcls = tcls->superclass) {
//        if (tcls == cls) return YES;
//    }
//    return NO;
//}
//
//- (BOOL)isKindOfClass:(Class)cls {
//    for (Class tcls = [self class]; tcls; tcls = tcls->superclass) {
//        if (tcls == cls) return YES;
//    }
//    return NO;
//}
