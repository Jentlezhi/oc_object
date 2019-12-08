//
//  NSObject+Eat.m
//  CategoryDemo
//
//  Created by Jentle on 2019/11/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person+Eat.h"


@implementation Person (Eat)

- (void)eat {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

@end
