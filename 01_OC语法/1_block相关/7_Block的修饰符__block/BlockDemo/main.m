//
//  main.m
//  BlockDemo
//
//  Created by Jentle on 2019/11/20.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJPerson.h"

typedef void(^Block)(void);
 
void blockModifyVar(void);
//
//void blockModifyArray(void);
//
//void blockRefVar(void);

void blockWeakRefObjc(void);

//int a = 1;
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        blockModifyVar();
//        blockModifyArray();
//        blockWeakRefObjc();
//        __block int b = 2;
//        static int c = 3;
//        __block NSObject *obj = [NSObject new];
//        void(^block)(void) = ^{
//            a = 10;
//            b = 20;
////            c = 30;
//            obj = nil;
//            NSLog(@"c = %d",c);
//        };
//        block();
//        a = 100;
//        b = 200;
//        c = 300;
//        block();
//        NSLog(@"a = %d",a);//10
//        NSLog(@"b = %d",b);//20
//        NSLog(@"c = %d",c);//30
//        NSLog(@"obj = %@",obj);//
    }
    return 0;
}

void blockModifyVar(){
    ///__block会把a包装成一个对象__Block_byref_a_0，a变成这个对象的一个成员变量
    __block int a = 10;
    Block block = ^{
        a = 11;///block内部修改的是就是这个对象__Block_byref_a_0内部的成员变量的值
    };
    block();
    ///
    NSLog(@"a=%d",a);///这里访问的也是__Block_byref_a_0这个成员变量的值
}
//
//void blockModifyArray(){
//    NSMutableArray *list = @[].mutableCopy;
//    Block block = ^{
//        [list addObject:@0];
//        [list addObject:@1];
//    };
//    block();
//    NSLog(@"list=%@",list);
//    /*
//     list=(
//         0,
//         1
//     )
//     */
//}
//
//void blockRefVar(){
//    NSObject *objc = [[NSObject alloc] init];
//    __block int a = 10;
//    __weak NSObject *weakObjc = objc;
//    Block block = ^{
//        NSLog(@"objc = %@",objc);
//        NSLog(@"a = %d",a);
//        NSLog(@"weakObjc = %@",weakObjc);
//    };
//    block();
//}
//void blockWeakRefObjc(){
//    MJPerson *p = [[MJPerson alloc] init];
//    __block __strong MJPerson *weakP = p;
//    Block block = ^{
//        NSLog(@"weakP = %@",weakP);
//    };
//    block();
//}
