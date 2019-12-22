//
//  Dog.m
//  MRCDemo
//
//  Created by Jentle on 2019/12/21.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Dog.h"

@implementation Dog

- (void)run {
    
    NSLog(@"%s",__func__);
}


- (void)dealloc
{
    [super dealloc];
    NSLog(@"%s",__func__);
}

@end
