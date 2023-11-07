//
//  Person.h
//  AppDemo
//
//  Created by Jentle on 2022/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property(assign, nonatomic) int age;

@property(copy, nonatomic) NSString *name;

@property(copy, nonatomic) void(^block)(void);

@end

NS_ASSUME_NONNULL_END
