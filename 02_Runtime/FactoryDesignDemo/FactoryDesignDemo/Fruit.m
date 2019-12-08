//
//  Fruit.m
//  FactoryDesignDemo
//
//  Created by Jentle on 2019/12/7.
//  Copyright © 2019 Jentle. All rights reserved.
//  抽象类

#import "Fruit.h"

#define ThrowException(msg)\
@throw \
[NSException exceptionWithName:NSInternalInconsistencyException \
                        reason:msg \
                      userInfo:nil]

#define MethodNotImplemented() \
@throw \
[NSException exceptionWithName:NSInternalInconsistencyException \
                        reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)] \
                      userInfo:nil]

@implementation Fruit

- (instancetype)init {
    
    if ([self isMemberOfClass:[Fruit class]]) {
        ThrowException(@"Fruit is abstract class, You can not init a abstract class");
        return nil;
    }else{
        if (self = [super init]) {
            
        }
        return self;
    }
}

- (void)showPrice {
    
    MethodNotImplemented();
}


@end

@interface Apple : Fruit

@end

@implementation Apple

- (void)showPrice {
    
    NSLog(@"%@ price is %@",[self class],@"$10");
}

@end

@interface Banana : Fruit

@end

@implementation Banana

- (void)showPrice {
    
    NSLog(@"%@ price is %@",[self class],@"$8");
}

@end

@interface Pear : Fruit

@end

@implementation Pear

- (void)showPrice {
    
    NSLog(@"%@ price is %@",[self class],@"$3");
}

@end



