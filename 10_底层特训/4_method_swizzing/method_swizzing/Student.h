//
//  Student.h
//  method_swizzing
//
//  Created by Jentle on 2021/10/27.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student : Person

@property(assign, nonatomic) int age;

- (void)studentInstanceMethod;

@end

NS_ASSUME_NONNULL_END
