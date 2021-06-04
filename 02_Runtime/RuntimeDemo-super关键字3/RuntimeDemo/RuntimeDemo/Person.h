//
//  Person.h
//  RuntimeDemo
//
//  Created by Jentle on 2019/11/25.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property(copy, nonatomic) NSString *name;

- (void)run;

+ (void)run;

@end

NS_ASSUME_NONNULL_END
