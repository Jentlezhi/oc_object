//
//  Person.h
//  KVO_basic
//
//  Created by Jentle on 2019/9/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    @public
    double weight;
}

/// 年龄
@property(assign, nonatomic) NSInteger age;

@property(strong, nonatomic) NSMutableArray <NSString*>*array;


//fullName依赖firstName和lastName
@property(copy, nonatomic) NSString *fullName;
@property(copy, nonatomic) NSString *firstName;
@property(copy, nonatomic) NSString *lastName;

- (void)test;

- (void)callObserHandly;

@end

NS_ASSUME_NONNULL_END
