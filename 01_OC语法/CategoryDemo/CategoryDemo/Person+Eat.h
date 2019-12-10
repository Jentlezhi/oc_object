//
//  NSObject+Eat.h
//  CategoryDemo
//
//  Created by Jentle on 2019/11/11.
//  Copyright © 2019 Jentle. All rights reserved.
//


#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (Eat)

///通过runtime动态的将分类方法合并到类对象、元类对象中
- (void)eat;

@end

NS_ASSUME_NONNULL_END
