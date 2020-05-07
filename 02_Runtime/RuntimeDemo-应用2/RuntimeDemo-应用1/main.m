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
#import "GoodStudent.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDictionary *json = @{@"name":@"Jentle",
                               @"weight":@180,
                               @"age":@18,
                               @"no":@10087,
                               @"rank":@1
        };
        Person *p = [Person zjt_objectWithJson:json];
        NSLog(@"name:%@ weight:%d age:%d",p.name, p.weight,p.age);
        NSLog(@"----------------------");
        Student *s = [Student zjt_objectWithJson:json];
        NSLog(@"name:%@ weight:%d age:%d no:%ld",s.name, s.weight,s.age,(long)s.no);
        NSLog(@"------------------------------");
        GoodStudent *gStu = [GoodStudent zjt_objectWithJson:json];
        NSLog(@"name:%@ weight:%d age:%d no:%ld rank:%d",gStu.name, gStu.weight,gStu.age,(long)gStu.no,gStu.rank);
    }
    return 0;
}
