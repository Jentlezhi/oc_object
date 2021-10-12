//
//  JTPermenantThread.h
//  RunLoop
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JTThreadTask)(void);

NS_ASSUME_NONNULL_BEGIN

@interface JTPermenantThread : NSObject

- (void)executeTask:(JTThreadTask)task;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
