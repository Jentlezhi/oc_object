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
    //allocWithZone，系统重新分配好的空间，默认返回一个新对象
    Person *p = [Person allocWithZone:zone];
    p.age = self.age;
    p.name = self.name;
//    [p copyAllValueWithTarget:self];
    return p;
}

//- (void)setData:(NSMutableArray *)data {
//    
//    //_data != data表示传来的是个新对象
//    if (_data != data) {
//        [_data release];//先释放旧对象
//        /*
//         再根据@property的属性执行相关操作,
//         copy出来就是一个不可变对象
//         */
//        _data = [data copy];
//    }
//}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@, no = %@ age = %zd", self.name,self.no,self.age];
}

@end
