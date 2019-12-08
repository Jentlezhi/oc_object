//
//  main.m
//  ClassClusterDemo
//
//  Created by Jentle on 2019/12/8.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSNumber *aChar = [NSNumber numberWithChar:'a'];
        NSLog(@"aChar：%@", [[aChar class] description]);
        NSNumber *anBool = [NSNumber numberWithBool:YES];
        NSLog(@"anBool：%@", [[anBool class] description]);
//        NSNumber *aFloat = [NSNumber numberWithFloat:1.0];
//        NSLog(@"aFloat：%@", [[aFloat class] description]);
//        NSNumber *aDouble = [NSNumber numberWithDouble:1.0];
//        NSLog(@"aDouble：%@", [[aDouble class] description]);
    }
    return 0;
}
