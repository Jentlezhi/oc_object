//
//  Person.h
//  BlockDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

/// age
@property(assign, nonatomic) int age;

@property(copy, nonatomic) NSSet *name;
///block
@property(copy, nonatomic) void(^block)(void);

- (void)test;

@end

NS_ASSUME_NONNULL_END
