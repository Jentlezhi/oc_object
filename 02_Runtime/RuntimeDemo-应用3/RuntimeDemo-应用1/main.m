//
//  main.m
//  RuntimeDemo-应用1
//
//  Created by Jentle on 2019/12/4.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>

void myRun(void){
    
    NSLog(@"%s",__func__);
}

void replaceMethod(){
    
    Person *p = [[Person alloc] init];
    class_replaceMethod([Person class], @selector(run), (IMP)myRun, "v");
    [p run];//myRun
}

void replaceMethodWithBlock(){
    
    Person *p = [[Person alloc] init];
    ///block包装成一个IMP
    class_replaceMethod([Person class], @selector(run), imp_implementationWithBlock(^{
        NSLog(@"imp_implementationWithBlock");
    }), "v");
    [p run];//imp_implementationWithBlock
}

void exchangeImp(){
    
    Person *p = [[Person alloc] init];
    Method runMethod = class_getInstanceMethod([Person class], @selector(run));
    Method testMethod = class_getInstanceMethod([Person class], @selector(test));
    method_exchangeImplementations(runMethod, testMethod);
    [p run];//[Person test]
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        replaceMethodWithBlock();
    }
    return 0;
}
