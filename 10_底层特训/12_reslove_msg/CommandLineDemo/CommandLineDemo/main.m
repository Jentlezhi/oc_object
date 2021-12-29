//
//  main.m
//  CommandLineDemo
//
//  Created by Jentle on 2021/11/26.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Teacher.h"
#import <objc/message.h>


void _objc_flush_caches(Class cls);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        [Teacher noImpClassMethod];
        Teacher *to = [Teacher new];
//        [to description];
        _objc_flush_caches([to class]);
        id res = [(NSString *)to uppercaseString];
    }
    return 0;
}
