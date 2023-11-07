//
//  NSObject+KVO.h
//  AppDemo
//
//  Created by Jentle on 2022/2/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KVO)

- (void)custom_addObserver:(NSObject *)observer
                forKeyPath:(NSString *)keyPath
                   options:(NSKeyValueObservingOptions)options
                   context:(nullable void *)context
                completion:(void(^)(NSString *keyPath,id object,NSDictionary<NSKeyValueChangeKey,id> *change,void * context))block;

- (void)custom_removeObserver:(NSObject *)observer
                   forKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
