//
//  Student+Test.h
//  CategoryAddPropertyDemo
//
//  Created by Jentle on 2019/11/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (Test)

/// name
@property(copy, nonatomic) NSString *name;
/// gender
@property(copy, nonatomic) NSString *gender;

@end

NS_ASSUME_NONNULL_END
