//
//  main.m
//  CommandLineDemo
//
//  Created by Jentle on 2021/11/26.
//

#import <Foundation/Foundation.h>
#import "Person.h"

typedef uint32_t mask_t;  // x86_64 & arm64 asm are less efficient with 16-bits

struct my_bucket_t {
    SEL _sel;
    uintptr_t _imp;
};

struct my_cache_t {
//    uintptr_t _bucketsAndMaybeMask;
    struct my_bucket_t  *_buckets;
    mask_t    _maybeMask;
    uint16_t  _flags;
    uint16_t  _occupied;
    struct my_bucket_t *buckets;
};

struct my_class_data_bits_t {
    // Values are the FAST_ flags above.
    uintptr_t bits;
};

struct my_objc_class {
    Class isa;
    Class superclass;
    struct my_cache_t cache;
    struct my_class_data_bits_t bits;
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p = [Person new];
        [p say1];
//        [p say2];
//        [p say3];
//        [p say4];
//        [p say5];
//        [p say6];
//        [p say7];
        //_maybeMask-扩容
        //4-1=3
        //8-1=7
        //16-1=15
        
        Class pClass = [p class];
        struct my_objc_class *my_custom_class = (__bridge struct my_objc_class *)(pClass);
        NSLog(@"superclass = %@",my_custom_class->superclass);
        NSLog(@"_occupied = %u",my_custom_class->cache._occupied);
        NSLog(@"_maybeMask = %u",my_custom_class->cache._maybeMask);
        NSLog(@"-- function --");
        for (int i = 0; i < my_custom_class->cache._occupied; i++) {
            struct my_bucket_t bucket = my_custom_class->cache._buckets[i];
            NSLog(@"sel = %@ - imp = %lu",NSStringFromSelector(bucket._sel),bucket._imp);
        }
        //sel = syaHello - imp = 48592
        //sel = init - imp = 140729440448221
    }
    return 0;
}
