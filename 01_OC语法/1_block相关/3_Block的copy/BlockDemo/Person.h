//
//  Person.h
//  BlockDemo
//
//  Created by Jentle on 2022/3/17.
//  Copyright © 2022 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property(assign, nonatomic) int age;
@property(copy, nonatomic) NSString *name;

@end

NS_ASSUME_NONNULL_END
