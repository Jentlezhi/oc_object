//
//  Person.h
//  AppDemo
//
//  Created by Jentle on 2022/3/14.
//

#import <Foundation/Foundation.h>
#import "MyProtocol.h"
#import "OtherProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<MyProtocol,OtherProtocol>

@end

NS_ASSUME_NONNULL_END
