//
//  Person.m
//  KVO_basic
//
//  Created by Jentle on 2019/9/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)init {
    
    if (self = [super init]) {
        _array = NSMutableArray.new;
    }
    return self;
}

- (NSString *)fullName {
    
    return [NSString stringWithFormat:@"%@ %@",_firstName, _lastName];
}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    NSSet<NSString *> *keyPath = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString:@"fullName"]) {
        NSArray *affectingKeys = @[@"lastName",@"firstName"];
        keyPath = [keyPath setByAddingObjectsFromArray:affectingKeys];
    }
    return keyPath;
}






- (void)setAge:(NSInteger)age {
    
    _age = age;
    NSLog(@"Person Set方法%ld",(long)age);
    
}

- (void)willChangeValueForKey:(NSString *)key {
    NSLog(@"%@--%@", NSStringFromSelector(_cmd),key);
    [super willChangeValueForKey:key];
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"%@--%@", NSStringFromSelector(_cmd),key);
    ///内部又会调用监听器的observeValueForKeyPath:ofObject:change:context:监听方法
    ///注释掉[super didChangeValueForKey:key];方法将不会被监听到
    [super didChangeValueForKey:key];
}

///默认返回yes
+ (BOOL)accessInstanceVariablesDirectly {
    NSLog(@"%s",__func__);
    return YES;
}
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    return NO;
}

- (void)test {
    
    NSLog(@"Person - test");
}

- (void)callObserHandly {
    NSLog(@"callObserHandly");
    [self willChangeValueForKey:@"age"];
    _age = 1000;
    [self didChangeValueForKey:@"age"];
}

@end
