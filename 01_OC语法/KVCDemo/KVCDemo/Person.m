//
//  Person.m
//  KVCDemo
//
//  Created by Jentle on 2019/11/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person.h"


@interface Person ()



@property(copy, nonatomic) NSString *name;

@end


@implementation Person

//@synthesize name = myName;
//@dynamic name;

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _name
//        myName
        self.name = @"hhhhhhhhh";
//        NSLog(@"%@",self.name);
    }
    return self;
}

//- (NSInteger)getAge {
//
//    return 100;
//}

//- (NSInteger)age {
//
//    return 101;
//}

//- (NSInteger)isAge {
//
//    return 102;
//}
//
//- (NSInteger)_age {
//    
//    return 103;
//}

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    NSLog(@"%@--%@",NSStringFromSelector(_cmd),key);
}

- (void)didChangeValueForKey:(NSString *)key {
    [super didChangeValueForKey:key];
    NSLog(@"%@--%@",NSStringFromSelector(_cmd),key);
}

+ (BOOL)accessInstanceVariablesDirectly {
    
    return YES;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@",key);
}

@end
