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
///block
@property(copy, nonatomic) void(^block)(void);

@end

NS_ASSUME_NONNULL_END
