//
//  Person.h
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/17.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

/// array
@property(strong, atomic) NSMutableArray *data;

@end

NS_ASSUME_NONNULL_END
