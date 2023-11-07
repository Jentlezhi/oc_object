//
//  Person.h
//  CommandLineDemo
//
//  Created by Jentle on 2022/1/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property(copy, nonatomic) NSString *name;

- (void)saySomething;

@end

NS_ASSUME_NONNULL_END
