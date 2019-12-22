//
//  NSObject+Extension.m
//  MRCDemo
//
//  Created by Jentle on 2019/12/22.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (Extension)

- (void)copyAllValueWithTarget:(id)copyTarget {
    
    Class curCls = [self class];
    do {
        unsigned int outCount;
        Ivar *ivars = class_copyIvarList(curCls , &outCount);
        for (int i = 0; i < outCount; i ++) {
            Ivar ivar = ivars[i];
            NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
            [name deleteCharactersInRange:NSMakeRange(0, 1)];
            NSString *selectorSetName = [NSString stringWithFormat:@"set%@:",name.capitalizedString];
            NSString *selectorGetName = name;
            id value = ((NSString *(*)  (id , SEL))objc_msgSend)(copyTarget , NSSelectorFromString(selectorGetName));
            ((void *(*)  (id , SEL , NSString *))objc_msgSend)(self , NSSelectorFromString(selectorSetName) , value);
        }
        free(ivars);
        curCls = [curCls superclass];
    } while (curCls != [NSObject class]);
    
}

@end
