//
//  main.m
//  BlockDemo
//
//  Created by Jentle on 2019/11/20.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

void block_01(void);

void block_02(void);

void block_03(void);

void block_04(void);

void block_05(void);

void staticAndAuto(void);

void globalVariable(void);

///全局变量
int a_ = 111;
static int b_ = 222;

struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
};

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __Block_byref_val_0 {
  void *__isa;
 struct __Block_byref_val_0 *__forwarding;
 int __flags;
 int __size;
 int val;
};

struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
  struct __Block_byref_val_0 *val; // by ref
};

void stackBlock(void) {
    __block int val = 12;
    printf("block捕获val之前\n");
    printf("&val:%p, val:%d \n", &val, val);//&val:0x7ff7bfeff3f8, val:12
    struct __main_block_impl_0 *blockStruct = (__bridge struct __main_block_impl_0 *)^{
        printf("inBlock    &val:%p, val:%d \n", &val, val);
        ++val;
    };
    printf("block捕获val之后\n");
    printf("&val->__forwarding->val:%p, val:%d \n", &(blockStruct->val->__forwarding->val), blockStruct->val->__forwarding->val);//&val->__forwarding->val:0x7ff7bfeff3f8, val:12
    printf("&val:%p, val:%d \n", &val, val);//&val:0x7ff7bfeff3f8, val:12
}

void forwarding(){
    __block int val = 12;
    printf("block捕获val之前\n");
    printf("&val:%p, val:%d \n", &val, val);//&val:0x7ff7bfeff3f8, val:12
    void(^blk)(void) = ^{
        printf("inBlock    &val:%p, val:%d \n", &val, val);
        ++val;
    };
    struct __main_block_impl_0 *blockStruct = (__bridge struct __main_block_impl_0 *)blk;
    printf("block捕获val之后\n");
    printf("&val->__forwarding->val:%p, val:%d \n", &(blockStruct->val->__forwarding->val), blockStruct->val->__forwarding->val);//&val->__forwarding->val:0x600000214018, val:12
    printf("&val:%p, val:%d \n", &val, val);//&val:0x600000214018, val:12
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        base_01();
//        block_02();
//        block_03();
//        block_04();
//        block_05();
//        staticAndAuto();
//        globalVariable();
    }
    return 0;
}

void block_01(void){
    
    void(^block)(void) = ^{
        NSLog(@"Hello,world!");
    };
    block();
}

void block_02(void){
    
    void(^block)(int, int) = ^(int a, int b){
        NSLog(@"a:%d,b=%d",a,b);
    };
    block(12,34);
    NSLog(@"class = %@",[[block class] superclass]);//__NSGlobalBlock__ -> NSBlock -> NSObject
}

void block_03(void){
    
    int a = 12345;
    int b = 123;
    void(^block)(void) = ^{
        NSLog(@"a:%d",a);
    };
    a = 23456;
    block();
    ///执行结果 a:12345
}

void block_04(void){
    
    NSString *a = @"Hello";
    void(^block)(void) = ^{
        NSLog(@"a:%@",a);
    };
    a = @"world";
    block();
    ///执行结果 a:Hello
    NSString *b = @"Hello";
    NSString *c = b.copy;
    NSLog(@"before:c=%@",c);//Hello
    c = @"world";
    NSLog(@"b=%@",b);//Hello
    NSLog(@"after:c=%@",c);//world
}

void block_05(void){
    
    Person *p = [Person new];
    p->_age = 10;
    [p test];
    NSLog(@"%d",p->_age);
}

void staticAndAuto(void){
    
    ///默认的就是自动变量相当于 auto int a = 10;
    int a = 10;
    static int b = 11;
    void(^block)(void) = ^{
        NSLog(@"a:%d",a);
        NSLog(@"b:%d",b);
    };
    b = 12;
    block();
    ///执行结果 a:10 b:12
}

void globalVariable(void){
    void(^block)(void) = ^{
        NSLog(@"a_:%d",a_);
        NSLog(@"b_:%d",b_);
    };
//    a_ = 123;
//    b_ = 234;
    ///执行结果 a_:123 b_:234
    block();
    ///执行结果 a_:111 b_:222
}



