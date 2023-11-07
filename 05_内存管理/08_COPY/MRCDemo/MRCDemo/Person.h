//
//  Person.h
//  MRCDemo
//
//  Created by Jentle on 2019/12/22.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<NSCopying>

/// data
//@property(strong, nonatomic) NSMutableArray *data;

@property(copy, nonatomic) NSMutableArray *data;
/// name
@property(copy, nonatomic) NSString *name;
/// 学号
@property(copy, nonatomic) NSString *no;
/// 年龄
@property(assign, nonatomic) NSInteger age;

@end

NS_ASSUME_NONNULL_END
