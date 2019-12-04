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
#import "NSObject+Json.h"
#import "Student.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDictionary *json = @{@"name":@"Jentle",
                               @"weight":@180,
                               @"age":@18
        };
//        Person *p = [Person cxt_objectWithJson:json];
//        NSLog(@"name:%@ weight:%d age:%d",p.name, p.weight,p.age);
        Student *s = [Student cxt_objectWithJson:json];
        NSLog(@"name:%@ weight:%d age:%d",s.name, s.weight,s.age);
        
    }
    return 0;
}
