//
//  Person.h
//  AppDemo
//
//  Created by Jentle on 2022/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

{
    @public
    NSString *_nickName;
}

@property(assign, nonatomic) int age;

@property(copy, nonatomic) NSString *name;

@property(copy, nonatomic) NSString *address;

@end

NS_ASSUME_NONNULL_END
