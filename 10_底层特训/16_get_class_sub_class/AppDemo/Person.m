//
//  Person.m
//  AppDemo
//
//  Created by Jentle on 2022/1/25.
//

#import "Person.h"

@implementation Person

- (void)setAge:(int)age {
    [self willChangeValueForKey:@"age"];
    _age = age + 10;
    [self didChangeValueForKey:@"age"];
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    
    if ([key isEqualToString:@"age"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

@end
