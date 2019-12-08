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

@property(assign, nonatomic, getter=isTall) BOOL tall;
@property(assign, nonatomic, getter=isRich) BOOL rich;
@property(assign, nonatomic, getter=isHandsome) BOOL handsome;

@end

NS_ASSUME_NONNULL_END
