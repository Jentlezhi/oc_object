//
//  main.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/12/3.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void testAddress (){
    
    ///局部变量分配在栈空间
    ///栈空间分配，从高地址到低地址
    long long a = 1;//a:0x7ffee228dcb8
    long long b = 2;//b:0x7ffee228dcb0
    long long c = 3;//c:0x7ffee228dca8
    long long d = 4;//d:0x7ffee228dca0
    printf("a:%p\n",&a);
    printf("b:%p\n",&b);
    printf("c:%p\n",&c);
    printf("d:%p\n",&d);
    
}

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        testAddress();
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
