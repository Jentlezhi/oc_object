//
//  Person.h
//  AppDemo
//
//  Created by Jentle on 2022/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<NSCopying>

@property(strong, nonatomic) NSString *name;

@property(copy, nonatomic) NSString *address;


@end

NS_ASSUME_NONNULL_END
