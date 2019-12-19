//
//  NSTimerDelegate.h
//  MemoryManagement
//
//  Created by Jentle on 2019/12/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimerDelegate : NSObject

///timerActionBlock
@property(copy, nonatomic) void(^timerActionBlock)(void);

- (void)timerAction;

@end

NS_ASSUME_NONNULL_END
