//
//  MyProxy.h
//  AppDemo
//
//  Created by Jentle on 2022/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyProxy : NSProxy

- (id)initWithTarget1:(id)t1 target:(id)t2;

@end

NS_ASSUME_NONNULL_END
