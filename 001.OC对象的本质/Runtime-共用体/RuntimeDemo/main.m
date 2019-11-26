//
//  main.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

void bits(void);
void unionExp(void);
void structExp(void);
///结构体
struct Date {
    int year;
    int month;
    int day;
};


union var{
    long int l;
    int i;
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {

    }
    return 0;
}

void bits(){
    Person *p = [[Person alloc] init];
    p.tall = NO;
    p.rich = NO;
    p.handsome = YES;
    NSLog(@"isTall:%d",p.isTall);
    NSLog(@"isRich:%d",p.isRich);
    NSLog(@"isHandsome:%d",p.isHandsome);
}

void structExp(){
    
    struct Date date = {2019,11,26};
    printf("year:%d,month:%d,day:%d\n",date.year,date.month,date.day);
}

void unionExp(){
    
    union var v;
    v.l = 5;
    printf("v.l is %d\n",v.i);
    v.i = 6;
    printf("now v.l is %ld! the address is %p\n",v.l,&v.l);
    printf("now v.i is %d! the address is %p\n",v.i,&v.i);
}
