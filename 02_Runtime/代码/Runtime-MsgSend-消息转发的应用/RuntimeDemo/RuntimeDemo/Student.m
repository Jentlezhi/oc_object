//
//  Student.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/12/3.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Student.h"

@implementation Student

/*
 static void _I_Student_print(Student * self, SEL _cmd) {

     ((void (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("Student"))}, sel_registerName("print"));

     int a = 10;
 }
 */

- (void)print {
    
    [super print];
    /*
     objc_msgSendSuper({self, (id)class_getSuperclass(objc_getClass("Student"))}, sel_registerName("print"));
     */
    
    int a = 10;
}

@end
