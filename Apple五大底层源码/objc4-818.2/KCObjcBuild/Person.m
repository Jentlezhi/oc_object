//
//  Person.m
//  KCObjcBuild
//
//  Created by Jentle on 2021/12/21.
//

#import "Person.h"

@implementation Person

//实现了load方法的是非懒加载类，没有实现的是懒加载类
+ (void)load {
    NSLog(@"%s",__func__);
}

- (void)say1 {
    
    NSLog(@"%s",__func__);
}

- (void)say2 {
    
    NSLog(@"%s",__func__);
}

- (void)say3 {
    
    NSLog(@"%s",__func__);
}

- (void)dealloc
{
    NSLog(@"Person对象销毁了---");
}

@end
