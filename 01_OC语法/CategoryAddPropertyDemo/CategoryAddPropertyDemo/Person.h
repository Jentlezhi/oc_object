//
//  Person.h
//  CategoryAddPropertyDemo
//
//  Created by Jentle on 2019/11/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

/// age
@property(assign, nonatomic) NSInteger age;


@property(copy, nonatomic) NSString *name;

@end

NS_ASSUME_NONNULL_END
