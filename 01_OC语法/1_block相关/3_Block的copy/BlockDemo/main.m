//
//  main.m
//  BlockDemo
//
//  Created by Jentle on 2019/11/20.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

typedef void(^Block)(void);

Block blockFunc(void){
    
    int a = 100;
//    Block block = ^{
//      NSLog(@"blockFunc:%d",a);
//    };
    Block block = ^{
      NSLog(@"blockFunc");
    };
    NSLog(@"in blockFunc - %@",[block class]);
    ///block是NSStackBlock__，存放在栈中,copy之后block会从栈区复制到堆区。
    id b = [block copy];
    NSLog(@"return block type - %@",[b class]);
    return b;
}

//void test1(void){
//    int a = 10;
////    myBlock = ^{
////        NSLog(@"%d",a);
////        NSLog(@"%s",__func__);
////    };
//    myBlock = [^{
//        NSLog(@"%d",a);
//        NSLog(@"%s",__func__);
//    } copy];
//    NSLog(@"test1 - %@",[myBlock class]);
//}

void (^myBlock)(void);
Block test1(void){
    int a = 10;
//    myBlock = ^{
//        NSLog(@"%d",a);
//        NSLog(@"%s",__func__);
//    };
    myBlock = ^{
        NSLog(@"%d",a);
        NSLog(@"%s",__func__);
    };
    NSLog(@"test1 - %@",[myBlock class]);
    return  myBlock;
}

void test2(void){
    NSLog(@"test2 - %@",[myBlock class]);
    myBlock = test1();
    myBlock();
}

void test3(void){
    int a = 3;
    //被强指针引用，栈block会自动copy
    __weak Block block = myBlock = ^{
        NSLog(@"%d",a);
        NSLog(@"%s",__func__);
    };
    block();
    NSLog(@"test1 - %@",[myBlock class]);
}

void(^myBlockWithPar)(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop);
void test4(void){
    myBlockWithPar = ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){
        NSLog(@"%@",obj);
    };
    NSLog(@"test4 - %@",[myBlockWithPar class]);
    [@[@1,@2,@3] enumerateObjectsUsingBlock:myBlockWithPar];
    NSLog(@"test4 - %@",[myBlockWithPar class]);
}

void test5(void){
    {
        Block block;
        {
            Person *p = [Person new];
            p.age = 10;
            block = ^{
                NSLog(@"%d",p.age);
            };
        }//这行结束Person - dealloc
        NSLog(@"-- Person - end--");
    }//block的作用域
    NSLog(@"--block - end--");
}

void test6(void){
    {
        Block block;//
        {
            Person *p = [Person new];
            p.age = 10;
            
            __weak typeof(p) weakPerson = p;
            block = ^{
                NSLog(@"%d",weakPerson.age);
            };
        }//这行结束Person - dealloc
        NSLog(@"-- Person - end--");
    }//block的作用域
    NSLog(@"--block - end--");
}

void test7(void){
    //p 是auto变量
    Person *p = [Person new];
    p.age = 10;
    p.name = @"Jen";
    myBlock = ^{
        //这里捕获的是Person *，
        NSLog(@"%d",p.age);
        p.name = @"Jentle";
        NSLog(@"%s",__func__);
    };
    NSLog(@"%@",p.name);
    myBlock();
    NSLog(@"%@",p.name);
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        blockFunc();
//        test1();
//        test2();
//        test4();
        ///MRC下，Block block = blockFunc();执行完之后，栈上的内存被回收了
//        Block block = blockFunc();
        
        ///Thread 1: EXC_BAD_ACCESS (code=1, address=0x7ffeefc07570)
//        block();
//        NSLog(@"%@",[block class]);
//        test6();
    }
    return 0;
}


