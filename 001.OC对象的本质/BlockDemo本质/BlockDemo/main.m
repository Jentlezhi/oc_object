//
//  main.m
//  BlockDemo
//
//  Created by Jentle on 2019/11/20.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

void block_01(void);

void block_02(void);

void block_03(void);

void block_04(void);

void staticAndAuto(void);

void globalVariable(void);

///全局变量
int a_ = 111;
static int b_ = 222;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        base_01();
//        block_02();
//        block_03();
//        block_04();
//        staticAndAuto();
        globalVariable();
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
    NSLog(@"before:c=%@",c);
    c = @"world";
    NSLog(@"b=%@",b);
    NSLog(@"after:c=%@",c);
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



