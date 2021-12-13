//
//  Student.m
//  KCObjcBuild
//
//  Created by Jentle on 2021/10/19.
//

#import "Student.h"
#import <objc/runtime.h>

@implementation Student

//+ (void)load {
//    
//    NSLog(@"%s",__func__);
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method m1 = class_getInstanceMethod(self, @selector(personInstanceMethod));
//        Method m2 = class_getInstanceMethod(self, @selector(studentInstanceMethod));
//        method_exchangeImplementations(m1, m2);
//    });
//}

- (void)studentInstanceMethod {
    
    NSLog(@"-- student -studentInstanceMethod--");
}

//+ (void)initialize {
//    
//    NSLog(@"%s",__func__);
//}

+ (void)studentClassMethod {
    
    NSLog(@"%s",__func__);
}

@end
