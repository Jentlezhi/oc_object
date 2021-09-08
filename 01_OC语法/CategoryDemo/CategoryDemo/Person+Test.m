//
//  NSObject+Test.m
//  CategoryDemo
//
//  Created by Jentle on 2019/11/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person+Test.h"
#import <objc/message.h>


@implementation Person (Test)

- (void)test {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)setName:(NSString *)name {
    
    objc_setAssociatedObject(self, _cmd, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name {
    
    return objc_getAssociatedObject(self, @selector(setName:));
}

@end
