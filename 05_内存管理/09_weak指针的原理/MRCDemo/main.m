//
//  main.m
//  MRCDemo
//
//  Created by Jentle on 2019/12/21.
//  Copyright © 2019 Jentle. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        __strong Person *person1;
        __weak Person *person2;
        __unsafe_unretained Person *person3;
        NSLog(@"begin");
        {
            Person *person = [[Person alloc] init];
            person2 = person;
        }
        NSLog(@"end");
//        NSLog(@"person2 = %@",person2);//person2 = (null)
//         NSLog(@"person3 = %@",person3);//Thread 1: EXC_BAD_INSTRUCTION (code=EXC_I3
        
    }
    return 0;
}
