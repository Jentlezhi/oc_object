//
//  main.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
#import "MJClassInfo.h"


void(cacheMember)(void);

void(cacheMember)(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
    }
    return 0;
}

void(cacheMember)() {
    
    Student *stu = [[Student alloc] init];
    mj_objc_class *studentClass = (__bridge mj_objc_class *)[Student class];
    
    NSLog(@"mask：%u",studentClass->cache._mask);
    NSLog(@"stu调用studentTest前：%u",studentClass->cache._occupied);
    [stu studentTest];
    NSLog(@"stu调用studentTest后：%u",studentClass->cache._occupied);

    NSLog(@"stu调用personTest前：%u",studentClass->cache._occupied);
    [stu personTest];
    NSLog(@"stu调用personTest后：%u",studentClass->cache._occupied);

    [stu othetStudentTest];
    NSLog(@"mask：%u",studentClass->cache._mask);
}
