//
//  Person.h
//  AppDemo
//
//  Created by Jentle on 2022/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property(nonatomic, copy) void(^myBlock)(void);

@end

NS_ASSUME_NONNULL_END
