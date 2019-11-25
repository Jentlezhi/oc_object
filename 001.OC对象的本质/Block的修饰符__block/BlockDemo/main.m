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
 
void blockModifyVar(void);

void blockModifyArray(void);

void blockRefVar(void);

void blockWeakRefObjc(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        blockWeakRefObjc();
    }
    return 0;
}

void blockModifyVar(){
    __block int a = 10;
    Block block = ^{
        a = 11;
    };
    block();
    NSLog(@"block type=%@",[block class]);
    NSLog(@"a=%d",a);
}

void blockModifyArray(){
    NSMutableArray *list = @[].mutableCopy;
    Block block = ^{
        [list addObject:@0];
        [list addObject:@1];
    };
    block();
    NSLog(@"list=%@",list);
}

void blockRefVar(){
    NSObject *objc = [[NSObject alloc] init];
    __block int a = 10;
    __weak NSObject *weakObjc = objc;
    Block block = ^{
        NSLog(@"objc = %@",objc);
        NSLog(@"a = %d",a);
        NSLog(@"weakObjc = %@",weakObjc);
    };
    block();
}
void blockWeakRefObjc(){

    __block Person *p = [[Person alloc] init];
    Block block = ^{
        NSLog(@"p = %@",p);
    };
    block();
}
