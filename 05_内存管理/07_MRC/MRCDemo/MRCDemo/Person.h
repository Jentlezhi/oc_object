//
//  Person.h
//  MRCDemo
//
//  Created by Jentle on 2019/12/21.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

- (void)setDog:(nullable Dog*)dog;

- (Dog *)dog;

@end

NS_ASSUME_NONNULL_END
