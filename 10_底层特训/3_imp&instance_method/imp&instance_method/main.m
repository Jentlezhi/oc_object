//
//  main.m
//  imp&instance_method
//
//  Created by Jentle on 2021/10/19.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Person.h"

void instanceAndClassMethod(void) {
    
    Method method1 = class_getInstanceMethod([Person class], @selector(instanceMethod));
    Method method2 = class_getInstanceMethod(objc_getMetaClass("Person"), @selector(instanceMethod));
    Method method3 = class_getInstanceMethod([Person class], @selector(classMethod));
    Method method4 = class_getInstanceMethod(objc_getMetaClass("Person"), @selector(classMethod));
    NSLog(@"method1 = %p",method1);//method1 = 0x100008090
    NSLog(@"method2 = %p",method2);//method2 = 0x0
    NSLog(@"method3 = %p",method3);//method3 = 0x0
    NSLog(@"method4 = %p",method4);//method4 = 0x100008028
    /*
     总结:
     1.对象方法存储在类对象里
     2.类方法存储在元类对象里
     */
}

void methodImp(void){
    
    IMP imp1 = class_getMethodImplementation([Person class], @selector(instanceMethod));
    IMP imp2 = class_getMethodImplementation(objc_getMetaClass("Person"), @selector(instanceMethod));
    IMP imp3 = class_getMethodImplementation([Person class], @selector(classMethod));
    IMP imp4 = class_getMethodImplementation(objc_getMetaClass("Person"), @selector(classMethod));
    NSLog(@"imp1 = %p",imp1);//imp1 = 0x100003c20
    NSLog(@"imp2 = %p",imp2);//imp2 = 0x7fff204685c0 imp2    IMP    (libobjc.A.dylib`_objc_msgForward)    0x00007fff204685c0
    NSLog(@"imp3 = %p",imp3);//imp3 = 0x7fff204685c0 imp2    IMP    (libobjc.A.dylib`_objc_msgForward)    0x00007fff204685c0
    NSLog(@"imp4 = %p",imp4);//imp4 = 0x100003c50
}

int main(int argc, const char * argv[]) {
    
    instanceAndClassMethod();
    methodImp();
    return 0;
}

