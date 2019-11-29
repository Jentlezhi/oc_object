//
//  main.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
#import "MJClassInfo.h"


void(encode)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p = [[Person alloc] init];
        [p personTest];
        mj_objc_class *personClass = (__bridge mj_objc_class *)[Person class];
        Student *s = [[Student alloc] init];
        mj_objc_class *stuClass = (__bridge mj_objc_class *)[Student class];
        [s studentTest];
        [s personTest];
        [s studentOtherTest];
        cache_t cache = stuClass->cache;
        NSLog(@"-------------------------");
        bucket_t *buckets = cache._buckets;
        for (int i = 0; i < cache._mask; i++) {
            bucket_t bucket = buckets[i];
            NSLog(@"%s:%p",bucket._key,bucket._imp);
        }
    }
    return 0;
}
