//
//  Student.m
//  MRCDemo
//
//  Created by Jentle on 2019/12/22.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Student.h"
#import "NSObject+Extension.h"

@implementation Student

- (id)copyWithZone:(NSZone *)zone {
    
    Student *s = [Student allocWithZone:zone];
    [s copyAllValueWithTarget:self];
    return s;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"payed = %d, data = %@, name = %@, no = %@ age = %zd rank = %d",self.payed,self.data, self.name,self.no,self.age,self.rank];
}

@end
