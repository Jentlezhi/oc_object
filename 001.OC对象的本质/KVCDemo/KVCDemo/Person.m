//
//  Person.m
//  KVCDemo
//
//  Created by Jentle on 2019/11/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person.h"

@implementation Person

//- (NSInteger)getAge {
//
//    return 100;
//}

//- (NSInteger)age {
//
//    return 101;
//}

- (NSInteger)isAge {

    return 102;
}

- (NSInteger)_age {
    
    return 103;
}

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    NSLog(@"%@--%@",NSStringFromSelector(_cmd),key);
}

- (void)didChangeValueForKey:(NSString *)key {
    [super didChangeValueForKey:key];
    NSLog(@"%@--%@",NSStringFromSelector(_cmd),key);
}



@end
