//
//  main.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p = [[Person alloc] init];
        p.tall = YES;
        p.rich = NO;
        p.handsome = YES;
        NSLog(@"isTall:%d",p.isTall);
        NSLog(@"isRich:%d",p.isRich);
        NSLog(@"isHandsome:%d",p.isHandsome);
    }
    return 0;
}
