//
//  ViewController.m
//  alloc&init
//
//  Created by Jentle on 2021/10/13.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>
#import <malloc/malloc.h>

@interface ViewController ()

@end

@implementation ViewController


int sum(int a, int b) {
    
    return a + b;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allocInit];
//    [self word_align];
//    [self size];
//    [Person classMethod];
    [self sturctAlign];
}

- (void)allocInit {
    
    Person *p = [Person alloc];
    Person *p1 = [p init];
    Person *p2 = [p init];
    NSLog(@"p = %p - %p",p, &p);//p = 0x60000344c8f0 - 0x7ffee32120a0
    NSLog(@"p1 = %p - %p",p1, &p1);//p1 = 0x60000344c8f0 - 0x7ffee3212098
    NSLog(@"p2 = %p - %p",p2, &p2);//p2 = 0x60000344c8f0 - 0x7ffee3212090
}

- (void)optimize {
    //build setting -> optimization level
    int c = sum(11, 22);
    NSLog(@"c = %d",c);
}

- (void)word_align {
    
    size_t (^block)(size_t x) = ^(size_t x){
        /*
         WORD_MASK = 7UL UL:无符号长整型
         static inline size_t word_align(size_t x) {
             return (x + WORD_MASK) & ~WORD_MASK;
         }
         */
//        int WORD_MASK_ = 7;
//        return (x + WORD_MASK_) & ~WORD_MASK_;
        
        /*
         x + WORD_MASK: 让最高位在其他位有值的情况下进一位
         >> STEP << STEP>：右移STEP，再右移STEP，这样除最高位外其他位均被置为0
         */
        int ALIGN_VALUE = 16;//对齐数
        int WORD_MASK = ALIGN_VALUE - 1;
        int STEP = (int)log2 (ALIGN_VALUE);
        return (x + WORD_MASK) >> STEP << STEP;
    };
    
    size_t alignNum = block(16);
    NSLog(@"alignNum = %zu",alignNum);
    Person *p = [Person new];
    NSLog(@"p align = %zu",class_getInstanceSize([p class]));
}

- (void)size {
    
    Person *p = [Person new];
    size_t size1 = class_getInstanceSize([p class]);
    size_t size2 = malloc_size((__bridge const void*)(p));
    NSLog(@"size1 = %zu",size1);
    NSLog(@"size2 = %zu",size2);
}

- (void)sturctAlign {
    /*
     内存对齐的原则：
     1.第一个成员在结构体变量偏移量为0 的地址处，也就是第一个成员必须从头开始。
     2.其他成员变量要对齐到某个数字（对齐数）的整数倍的地址处，如果一个结构
       里有某些结构体成员,则结构体成员要从其内部最大元素大小的整数倍地址开始存储。
     3.结构体总大小为最大成员的整数倍
     */
    struct Struct1 {
        double a; // double占8位 [0,7] - 原则1
        char b;   // char占1位 [8] - 原则2
        int c;    // int占4位 (9,...,[12,...,15] -原则2
        short d;  // short占2位 [16,17] -原则2
                  // 总大小[0,...,24] -原则3
    } struct1;
    
    struct Struct2 {
        double a; // double占8位 [0,7] - 原则1
        int b;    // int占4位 [8,...,11] -原则2
        char c;   // char占1位 [12] - 原则2
        short d;  // short占2位 (13,[14,15] -原则2
                  // 总大小[0,...,16] -原则3
    } struct2;
    
    struct Struct3 {
        double a; // double占8位 [0,7] - 原则1
        int b;    // int占4位 [8,...,11] -原则2
        char c;   // char占1位 [12] - 原则2
        short d;  // short占2位 (13,[14,15] -原则2
        int e;    // int占4位 [16,...,19] -原则2
        struct Struct1 str; //成员是结构体，从其内部最大元素大小的整数倍地址开始存储
                            //(20,...,[24,...47]
                 // 总大小[0,...,47] -原则3
    } struct3;
    
    NSLog(@"size of struct1 = %lu",sizeof(struct1));//size of struct1 = 24
    NSLog(@"size of struct2 = %lu",sizeof(struct2));//size of struct1 = 16
    NSLog(@"size of struct3 = %lu",sizeof(struct3));//size of struct1 = 48
}


@end
