//
//  Person.h
//  BlockDemo
//
//  Created by Jentle on 2019/11/21.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
{
    @public
    int _age;
}

- (void)sleep;
- (void)test;

@end

NS_ASSUME_NONNULL_END
