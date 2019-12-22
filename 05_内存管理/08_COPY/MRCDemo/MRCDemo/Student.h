//
//  Student.h
//  MRCDemo
//
//  Created by Jentle on 2019/12/22.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student : Person<NSCopying>

/// rank
@property(assign, nonatomic) int rank;

/// payed
@property(assign, nonatomic) BOOL payed;

@end

NS_ASSUME_NONNULL_END
