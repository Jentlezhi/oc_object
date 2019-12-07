//
//  FruitFactory.h
//  FactoryDesignDemo
//
//  Created by Jentle on 2019/12/8.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fruit.h"


NS_ASSUME_NONNULL_BEGIN

@interface FruitFactory : NSObject

+(Fruit *)createFruitWithName:(NSString *)fruitName;

@end

NS_ASSUME_NONNULL_END
