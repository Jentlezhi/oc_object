//
//  Student.m
//  RuntimeDemo
//
//  Created by Jentle on 2019/12/2.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Student.h"



struct objc_super {
    __unsafe_unretained _Nonnull id receiver;
    __unsafe_unretained _Nonnull Class super_class;
};

@implementation Student

- (instancetype)init
{
    self = [super init];
    if (self) {
        ///objc_msgSend(self,@selector(class));
        NSLog(@"[self class]:%@",[self class]);
        NSLog(@"[self superclass]:%@",[self superclass]);
        
        ///objc_msgSendSuper({self,[Person class]},@selector(class));
        ///super调用，消息接收者仍然是子类对象，只不过是从父类的类对象中搜索方法。
        ///[super class] == [self class]
        NSLog(@"[super class]:%@",[super class]);
        NSLog(@"[super superclass]:%@",[super superclass]);
    }
    return self;
}

- (void)run {
    
    [super run];
    /*
     ((void (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("Student"))}, sel_registerName("run"));
     */
    
    
    NSLog(@"%s", __func__);
}

@end
