//
//  Person.h
//  RuntimeDemo
//
//  Created by Jentle on 2019/12/3.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

/// name
@property(copy, nonatomic) NSString *name;

- (void)print;

- (NSString *)test:(NSString *)par;

@end

NS_ASSUME_NONNULL_END
