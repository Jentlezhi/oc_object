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

//void block1(void){
//
//    __weak Person *p = [Person new];
//    p.block = ^{
//        NSLog(@"%s",__func__);
//    };
//    NSLog(@"%@",[p.block class]);
//    NSLog(@"%d",p.age);
//    NSLog(@"%@",p.name);
//    //打印一下block
//    NSLog(@"%@",p.block);//(null)这是get方法，不会崩溃
//    p.block();//野指针错误:Thread 1: EXC_BAD_ACCESS (code=1, address=0x10)，因为这里是block的执行，block为空，去执行必须崩溃
//    /*
//     ((void (*(*)(id, SEL))())(void *)objc_msgSend)((id)p, sel_registerName("block"))();
//     */
//}
//
//void block2(void){
//
//    Block block = ^{
//        NSLog(@"block1");
//    };
//    block();
//    //把block置空
//    block = nil;
//    block();
//    /*
//     block = __null;
//     ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
//     */
//}

//void block2(void){
//    Person *p = [[Person alloc] init];
//    p.age =  10;
//    __weak Person *weakP = p;
////    __unsafe_unretained typeof(p) weakP = p;
//    p.block = ^{
//        NSLog(@"%d",weakP.age);
//    };
//    p.block();
//}


//void block3(void){
//
//    __block Person *p = [Person new];
//    Block block = ^{
//        NSLog(@"%@",p);
//    };
//    block();
//}

void block4(void){
    //weak
    __weak Person *weakP;
    {
        Person *p = [[Person alloc] init];
        p.age =  10;
        weakP = p;
    //    __unsafe_unretained typeof(p) weakP = p;
        p.block = ^{
            NSLog(@"%d",weakP.age);
        };
        p.block();
    }
    //这里p对象已经销毁，调用一下其对象方法
    [weakP test];
    
    //unsafe_unretained
    __unsafe_unretained Person *unretainedP;
    {
        Person *p = [[Person alloc] init];
        p.age =  10;
        unretainedP = p;
        p.block = ^{
            NSLog(@"%d",unretainedP.age);
        };
        p.block();
    }
    NSString *s = @"Jen";
    NSLog(@"%@",s);
    //这里p对象已经销毁，调用一下其对象方法
    [unretainedP test];
}

void block5(void) {
    __block Person *p = [[Person alloc] init];
    p.age =  10;
    p.block = ^{
        NSLog(@"%d",p.age);
        p = nil;
    };
    p.block();
}

void block6(void) {
    Person *p = [[Person alloc] init];
    [p test];
//    p.age =  10;
//    p.block = ^{
//        NSLog(@"%d",p.age);
//        p = nil;
//    };
//    p.block();
    NSLog(@"%s",__func__);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        block6();
    }
    return 0;
}


