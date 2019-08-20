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

@interface NSObject {
    Class isa;
}
@end

//c++代码
struct NSObject_IMPL {
    Class isa;
};


#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSObject *obj = [NSObject new];
        NSLog(@"Hello, World!");
    }
    return 0;
}
