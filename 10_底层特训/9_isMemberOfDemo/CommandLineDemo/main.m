//
//  main.m
//  CommandLineDemo
//
//  Created by Jentle on 2021/11/26.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Person : NSObject

- (void)sayHello;
+ (void)sayHappy;

@end

@implementation Person

- (void)sayHello{
    NSLog(@"Person say : Hello!!!");
}
+ (void)sayHappy{
    NSLog(@"Person say : Happy!!!");
}

@end

void instanceMethod_classToMetaclass(Class pClass){
    
    const char *className = class_getName(pClass);
    Class metaClass = objc_getMetaClass(className);
    
    Method method1 = class_getInstanceMethod(pClass, @selector(sayHello)); // 1
    Method method2 = class_getInstanceMethod(metaClass, @selector(sayHello)); // 0

    Method method3 = class_getInstanceMethod(pClass, @selector(sayHappy)); // 0
    Method method4 = class_getInstanceMethod(metaClass, @selector(sayHappy));// 1
    
    NSLog(@"%s===%p-%p-%p-%p",__func__,method1,method2,method3,method4);
}

void isKindOfDemo(void){
    
    BOOL re1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];       //
    BOOL re2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];     //
    BOOL re3 = [(id)[Person class] isKindOfClass:[Person class]];       //
    BOOL re4 = [(id)[Person class] isMemberOfClass:[Person class]];     //
    NSLog(@"\n re1 :%hhd\n re2 :%hhd\n re3 :%hhd\n re4 :%hhd\n",re1,re2,re3,re4);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        isKindOfDemo();
        Person  *p =  [Person new];
        instanceMethod_classToMetaclass([p class]);
        NSLog(@"Hello, World!");
    }
    return 0;
}
