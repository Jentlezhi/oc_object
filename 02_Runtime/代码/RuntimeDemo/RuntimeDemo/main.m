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
        NSLog(@"char占%lubit",sizeof(char));
        NSLog(@"int占%lubits",sizeof(int));
        Person *p = [[Person alloc] init];
        p.tall = YES;
        p.rich = YES;
        p.handsome = YES;
        NSLog(@"isTall:%d",p.isTall);
        NSLog(@"isRich:%d",p.isRich);
        NSLog(@"isHandsome:%d",p.isHandsome);
    }
    return 0;
}
