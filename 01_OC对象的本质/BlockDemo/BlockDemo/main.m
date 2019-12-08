//
//  main.m
//  BlockDemo
//
//  Created by Jentle on 2019/11/20.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>


struct __block_impl {
  void *isa;
  int Flags;
  int Reserved;
  void *FuncPtr;
};

struct __main_block_desc_2 {
  size_t reserved;
  size_t Block_size;
};

struct __main_block_impl_2 {
  struct __block_impl impl;
  struct __main_block_desc_2* Desc;
  int number;
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ///1.block默认不会执行，像函数一样，调用了才会执行，调用用()。
        ^{
            NSLog(@"this is a block");
        }();
        ///2.block的赋值
        void(^block)(void) = ^{
            NSLog(@"A");
            NSLog(@"B");
            NSLog(@"C");
        };
        block();
        ///3.block访问外界值
        int number = 10;
        void(^aBlock)(void) = ^{
            NSLog(@"number:%d",number);
        };
        
        struct __main_block_impl_2 *blockStruct = (__bridge struct __main_block_impl_2 *)aBlock;
        aBlock();
        
        
    }
    return 0;
}


