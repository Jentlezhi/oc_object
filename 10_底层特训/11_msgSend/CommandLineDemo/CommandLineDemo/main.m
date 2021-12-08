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
        Teacher *t = [Teacher new];
//        [p say1];
        /*
         Person *p = ((Person *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("Person"), sel_registerName("new"));
     ((void (*)(id, SEL))(void *)objc_msgSend)((id)p, sel_registerName("say1"));
         */
//        ((void (*)(id, SEL))(void *)objc_msgSend)((id)p, sel_registerName("say1"));
      //objc_msgSendSuper(void /* struct objc_super *super, SEL op, ... */)
        /*
         //super_class is the first class to search
         struct objc_super {
             /// Specifies an instance of a class.
             __unsafe_unretained _Nonnull id receiver;
             __unsafe_unretained _Nonnull Class super_class;
         }
         */
        struct objc_super my_objc_super;
        my_objc_super.receiver = p;
        my_objc_super.super_class = t.class;
        //需要：在Build Setting修改Enable Strict Checking of objc_msgSend Calls为No。
//        objc_msgSendSuper(&my_objc_super,@selector(say1));
        
        [t say1];
    }
    return 0;
}
