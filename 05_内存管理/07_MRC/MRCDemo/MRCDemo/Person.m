//
//  Person.m
//  MRCDemo
//
//  Created by Jentle on 2019/12/21.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person.h"

@implementation Person
{
    Dog *_dog;
}


- (void)setDog:(nullable Dog*)dog {
    
    if (_dog != dog) {
        [_dog release];
        _dog = [dog retain];
    }
}

- (Dog *)dog {
    
    return _dog;
}

- (void)dealloc
{
//    [_dog release];
//    _dog = nil;
    self.dog = nil;
    [super dealloc];
    NSLog(@"%s",__func__);
}

@end
