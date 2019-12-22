//
//  Person.m
//  MRCDemo
//
//  Created by Jentle on 2019/12/22.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>
#import "NSObject+Extension.h"

@implementation Person

- (id)copyWithZone:(NSZone *)zone {
    
    Person *p = [Person allocWithZone:zone];
    [p copyAllValueWithTarget:self];
    return p;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@, no = %@ age = %zd", self.name,self.no,self.age];
}

@end
