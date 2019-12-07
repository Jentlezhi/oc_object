//
//  main.m
//  FactoryDesignDemo
//
//  Created by Jentle on 2019/12/7.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FruitFactory.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fruit *apple = [FruitFactory createFruitWithName:@"Apple"];
        [apple showPrice];
        
        Fruit *banana = [FruitFactory createFruitWithName:@"Banana"];
        [banana showPrice];
        
        Fruit *pear = [FruitFactory createFruitWithName:@"Pear"];
        [pear showPrice];
        
    }
    return 0;
}
