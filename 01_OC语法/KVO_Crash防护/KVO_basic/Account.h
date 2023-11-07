//
//  Account.h
//  KVO_basic
//
//  Created by Jentle on 2022/1/24.
//  Copyright © 2022 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSObject

@property(assign, nonatomic) NSInteger interestRate;

@property(assign, nonatomic) NSInteger balance;

@end

NS_ASSUME_NONNULL_END
