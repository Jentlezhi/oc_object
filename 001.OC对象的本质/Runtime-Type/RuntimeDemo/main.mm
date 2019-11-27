//
//  main.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "MJClassInfo.h"


void(encode)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        encode();
        
        mj_objc_class *cls = (__bridge mj_objc_class *)[Person class];
        //窥探底层结构
        class_rw_t *data = cls->data();
        NSLog(@"%@",data);
    }
    return 0;
}

void encode(){
    
    NSLog(@"int - %s",@encode(int));
    NSLog(@"double - %s",@encode(double));
    NSLog(@"id - %s",@encode(id));
    NSLog(@"NSString - %s",@encode(NSString));
    NSLog(@"SEL - %s",@encode(SEL));
}
