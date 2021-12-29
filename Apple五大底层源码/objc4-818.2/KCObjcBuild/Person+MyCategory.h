//
//  Person+MyCategory.h
//  KCObjcBuild
//
//  Created by Jentle on 2021/12/24.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (MyCategory)

@property(copy, nonatomic) NSString *category_name;

- (void)categoryTest1;

- (void)categoryTest2;

@end

NS_ASSUME_NONNULL_END
