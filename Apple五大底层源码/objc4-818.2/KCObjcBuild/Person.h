//
//  Person.h
//  KCObjcBuild
//
//  Created by Jentle on 2021/9/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject



@property(copy, nonatomic) NSString *name;

@property(assign, nonatomic) int age;

@property(assign, nonatomic) int sex;

@property(copy, nonatomic) NSString *address;

- (void)personInstanceMethod;

+ (void)personClassMethod;

- (void)sayHello;
- (void)sayGoodBye;
+ (void)sayHappy;

@end

NS_ASSUME_NONNULL_END
