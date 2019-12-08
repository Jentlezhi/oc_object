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
{
    
    //成员变量
    ///身份证号
    @public
    NSString *_idCardNum;
    
    @public
    double height;
}

/// 声明属性
@property(assign, nonatomic) int age;

/// 声明属性
@property(assign, nonatomic) double height;

@end

NS_ASSUME_NONNULL_END
