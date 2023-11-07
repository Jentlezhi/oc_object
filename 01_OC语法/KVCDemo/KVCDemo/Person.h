//
//  Person.h
//  KVCDemo
//
//  Created by Jentle on 2019/11/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface Person : NSObject

//{
//    @public
//    NSInteger _age;
//}

{
    @public
    NSString *name;
}

@property(assign, nonatomic) NSInteger age;


@end

NS_ASSUME_NONNULL_END
