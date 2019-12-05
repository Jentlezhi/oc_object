//
//  NSObject+Json.m
//  RuntimeDemo-应用1
//
//  Created by Jentle on 2019/12/4.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "NSObject+Json.h"
#import <objc/runtime.h>

@implementation NSObject (Json)

////没有父类的情况
//+ (instancetype)cxt_objectWithJson:(NSDictionary *)json {
//
//    id obj = [[self alloc] init];
//    unsigned int outCount;
//    Ivar *ivars = class_copyIvarList(self, &outCount);
//    for (int i = 0; i < outCount; i ++) {
//        Ivar ivar = ivars[i];
//        NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
//        [name deleteCharactersInRange:NSMakeRange(0, 1)];
//        [obj setValue:json[name] forKey:name];
//    }
//    free(ivars);
//    return obj;
//}

+ (instancetype)cxt_objectWithJson:(NSDictionary *)json {
    
    id obj = [[self alloc] init];
    Class target = self;
    ///class_copyIvarList只能获取当前的成员变量，
    ///不能获取父类的，所以用while循环一层一层开始取成员变量。
    do {
        unsigned int outCount;
        Ivar *ivars = class_copyIvarList(target , &outCount);
        for (int i = 0; i < outCount; i ++) {
            Ivar ivar = ivars[i];
            NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
            ///移除首位的下划线
            [name deleteCharactersInRange:NSMakeRange(0, 1)];
            if (json[name]) {
                [obj setValue:json[name] forKey:name];
            }
        }
        free(ivars);
        target = [target superclass];
    } while (target != [NSObject class]);
    return obj;
}

@end
