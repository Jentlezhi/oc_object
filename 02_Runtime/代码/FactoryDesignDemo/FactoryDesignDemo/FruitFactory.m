//
//  FruitFactory.m
//  FactoryDesignDemo
//
//  Created by Jentle on 2019/12/8.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "FruitFactory.h"
#import "Fruit.h"

@interface FruitFactory ()

@end

@implementation FruitFactory

+ (Fruit *)createFruitWithName:(NSString *)fruitName{
    Class class_ = NSClassFromString(fruitName);
    Fruit *theFruit = [(Fruit *)[class_ alloc] init];
    return theFruit;
}


@end
