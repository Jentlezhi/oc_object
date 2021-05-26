//
//  NSObject+Json.h
//  RuntimeDemo-应用1
//
//  Created by Jentle on 2019/12/4.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Json)

+ (instancetype)zjt_objectWithJson:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
