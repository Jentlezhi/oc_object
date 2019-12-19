//
//  NSTimerDelegate.m
//  MemoryManagement
//
//  Created by Jentle on 2019/12/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "NSTimerDelegate.h"

@implementation NSTimerDelegate

- (void)timerAction {
    
    !self.timerActionBlock?:self.timerActionBlock();
}

@end
