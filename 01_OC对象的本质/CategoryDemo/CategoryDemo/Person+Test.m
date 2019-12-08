//
//  NSObject+Test.m
//  CategoryDemo
//
//  Created by Jentle on 2019/11/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person+Test.h"


@implementation Person (Test)

- (void)test {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

@end
