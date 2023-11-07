//
//  Person+Test.m
//  CategoryAddPropertyDemo
//
//  Created by Jentle on 2019/11/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "Person+Test.h"

///方法一：设置变量保存值：全局变量，共用。导致多个对象都用一个值。
float weight_;

///方法二：用字典建立self与值的关系
NSMutableDictionary *weights_;


@implementation Person (Test)

+ (void)load {
    
    weights_ = [NSMutableDictionary dictionary];
}

//- (void)setWeight:(float)weight {
//
//    weight_ = weight;
//}
//
//- (float)weight {
//
//    return weight_;
//}



- (void)setWeight:(float)weight {
    
    NSString *key = [NSString stringWithFormat:@"%p",self];
    weights_[key] = @(weight);
}

- (float)weight {
    
    NSString *key = [NSString stringWithFormat:@"%p",self];
    return [weights_[key] floatValue];
}

//- (void)setAge:(NSInteger)age {
//    NSLog(@"setAge");
//}

@end
