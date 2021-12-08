//
//  Person.m
//  KCObjcBuild
//
//  Created by Jentle on 2021/9/15.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person

//+ (void)load {
//
//    NSLog(@"%s",__func__);
//}
//
//+ (void)initialize {
//
//    NSLog(@"%s",__func__);
//}

//- (instancetype)init {
//    
//    if (self = [super init]) {
////        [self printAddress];
////        [self test2];
//    }
//    return self;
//}


//- (void)instanceMethod {
//    
//    NSLog(@"%s",__func__);
//}
//
//+ (void)classMethod {
//    
//    NSLog(@"%s",__func__);
//}
//
//- (void)printAddress {
//    
//    NSLog(@"%s",__func__);
//}
- (void)personInstanceMethod {
    
    NSLog(@"%s",__func__);
}
+ (void)personClassMethod {
    
    NSLog(@"%s",__func__);
}

- (void)sayHello {
    NSLog(@"Person say : Hello!!!");
}
- (void)sayGoodBye {
    NSLog(@"Person say : GoodBye!!!");
}
+ (void)sayHappy {
    NSLog(@"Person say : Happy!!!");
}


@end
