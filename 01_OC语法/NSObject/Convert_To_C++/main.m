//
//  main.m
//  Convert_To_C++
//
//  Created by Jentle on 2019/8/20.
//  Copyright © 2019 Jentle. All rights reserved.
//



/*
 @interface NSObject <NSObject> {
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Wobjc-interface-ivars"
 Class isa  OBJC_ISA_AVAILABILITY;
 #pragma clang diagnostic pop
 }
 */

//@interface NSObject {
//    Class isa;
//}
//@end

//c++代码
struct NSObject_IMPL {
    Class isa;
};


#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "JZPerson.h"
#import "NSObject+Test.h"

void test1(void) {
    [JZPerson test];
}
void test2(void) {
    NSObject *obj1 = [NSObject new];
    NSObject *obj2 = [NSObject new];
    
    Class cls1 = [obj1 class];
    Class cls2 = [obj2 class];
    NSLog(@"%p",cls1);//0x7ff85ee23270
    NSLog(@"%p",cls2);//0x7ff85ee23270
    
    Class mateClass1 = object_getClass(cls1);
    Class mateClass2 = object_getClass(cls2);
    NSLog(@"%p",mateClass1);//0x7ff85ee23220
    NSLog(@"%p",mateClass2);//0x7ff85ee23220
    
    Class objectClass = [[NSObject class] class];
    NSLog(@"%p",objectClass);//0x7ff85ee23270
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test1();
    }
    return 0;
}
