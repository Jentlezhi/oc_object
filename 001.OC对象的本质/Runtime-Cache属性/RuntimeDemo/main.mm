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
        [s studentOtherTest];
        [s personTest];
        cache_t cache = stuClass->cache;
        NSLog(@"-------_buckets的查看---------");
        NSLog(@"_occupied:%d",cache._occupied);
        NSLog(@"_mask:%d",cache._mask);
        bucket_t *buckets = cache._buckets;
        ///散列表的长度为mask + 1
        for (int i = 0; i < cache._mask; i++) {
            bucket_t bucket = buckets[i];
            NSLog(@"%s:%p",(char*)bucket._key,bucket._imp);
        }
        ///索引的生成
        NSLog(@"-------索引的生成--------");
        ///这里只是演示部分，有时候方法太多会有直接取出来失败的情况！！！！
        int index = (long long)@selector(personTest) & cache._mask;
        bucket_t bucket = buckets[index];
        NSLog(@"%s %p",(char*)bucket._key,bucket._imp);
        ///方法的封装
        IMP imp = cache.imp(@selector(personTest));
        NSLog(@"imp:%p",imp);
    }
    return 0;
}
