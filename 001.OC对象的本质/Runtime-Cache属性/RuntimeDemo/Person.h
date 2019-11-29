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
//v20@0:8c16
@property(assign, nonatomic, getter=isTall) BOOL tall;
@property(assign, nonatomic, getter=isRich) BOOL rich;
@property(assign, nonatomic, getter=isHandsome) BOOL handsome;

- (void)test;

@end

NS_ASSUME_NONNULL_END
