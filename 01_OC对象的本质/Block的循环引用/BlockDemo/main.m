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


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Person *p = [[Person alloc] init];
        p.age =  10;
//        __weak Person *weakP = p;
        __unsafe_unretained typeof(p) weakP = p;
        p.block = ^{
            NSLog(@"%d",weakP.age);
        };
        p.block();
    }
    return 0;
}


