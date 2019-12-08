//
//  main.m
//  BlockDemo
//
//  Created by Jentle on 2019/11/20.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

void blockSuperclass(void);

void (^block)(void);

void test(void);

void testCall(void);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int a = 11;
        ///1.没有访问auto变量：NSGlobalBlock
        void(^aBlock)(void) = ^{
            NSLog(@"aBlock");
        };
        NSLog(@"aBlock = %@",[aBlock class]);
        
        ///2.访问auto变量：NSStackBlock
        void(^bBlock)(void) = ^{
            NSLog(@"bBlock%d",a);
        };
        ///关闭ARC
        NSLog(@"bBlock = %@",[bBlock class]);
        
        ///3.NSStackBlock调用了copy: NSMallocBlock
        void(^cBlock)(void) = [bBlock copy];
        NSLog(@"cBlock = %@",[cBlock class]);
        ///手动release
        [cBlock release];
        
    }
    return 0;
}

void testCall(){
    
    test();
    block();
}

void test(){
    
    int a = 10;
    block = ^{
        NSLog(@"block:%d",a);
    };
}

void blockSuperclass(void){
    
    void(^block)(void) =^{
        NSLog(@"Hello,world!");
    };
    block();
    NSLog(@"block_type:%@",[block class]);
    NSLog(@"block_superclass_type:%@",[[block class] superclass]);
    NSLog(@"block_superclass_superclass_type:%@",[[[block class] superclass] superclass]);
    NSLog(@"block_superclass_superclass_superclass_type:%@",[[[[block class] superclass] superclass] superclass]);
    /*
     2019-11-21 15:22:57.599120+0800 BlockDemo[43990:6505461] Hello,world!
     2019-11-21 15:22:57.599499+0800 BlockDemo[43990:6505461] block_type:__NSGlobalBlock__
     2019-11-21 15:22:57.599535+0800 BlockDemo[43990:6505461] block_superclass_type:__NSGlobalBlock
     2019-11-21 15:22:57.599575+0800 BlockDemo[43990:6505461] block_superclass_superclass_type:NSBlock
     2019-11-21 15:22:57.599615+0800 BlockDemo[43990:6505461] block_superclass_superclass_superclass_type:NSObject
     */
}


