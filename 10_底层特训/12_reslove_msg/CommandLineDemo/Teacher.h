//
//  Teacher.h
//  CommandLineDemo
//
//  Created by Jentle on 2021/12/8.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Teacher : Person

+ (void)noImpClassMethod;
- (void)noImpInstanceMethod;

@end

NS_ASSUME_NONNULL_END
