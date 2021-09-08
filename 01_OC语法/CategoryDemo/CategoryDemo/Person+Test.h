//
//  NSObject+Test.h
//  CategoryDemo
//
//  Created by Jentle on 2019/11/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (Test)

- (void)test;

@property(copy, nonatomic) NSString *name;

@end

NS_ASSUME_NONNULL_END
