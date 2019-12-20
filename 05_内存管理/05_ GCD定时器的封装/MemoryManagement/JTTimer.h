//
//  JTTimer.h
//  MemoryManagement
//
//  Created by Jentle on 2019/12/20.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JTTimer : NSObject

+ (NSString *)executeTask:(void(^)(void))task
                    delay:(NSTimeInterval)delay
                 interval:(NSTimeInterval)interval
                  repeats:(BOOL)repeats
                    async:(BOOL)async;

+ (void)cancelTask:(NSString *)timerIdentifier;

@end

NS_ASSUME_NONNULL_END
