//
//  Person.h
//  RuntimeDemo-应用1
//
//  Created by Jentle on 2019/12/4.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

/// weight
@property(assign, nonatomic) int weight;

@property(assign, nonatomic) int age;
/// name
@property(copy, nonatomic) NSString *name;

- (void)run;

@end

NS_ASSUME_NONNULL_END
