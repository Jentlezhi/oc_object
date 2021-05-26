//
//  main.m
//  MRCDemo
//
//  Created by Jentle on 2019/12/21.
//  Copyright © 2019 Jentle. All rights reserved.
//  关闭自动内存管理

#import <Foundation/Foundation.h>
#import "objc/message.h"
#import "Person.h"
#import "Student.h"

void taggedPointerRetainCount(){
 
#if MRC
    NSString *str = [[NSString alloc] initWithFormat:@"test"];
    ///taggedPointer,retainCount为-1；
    NSLog(@"%@ - %zd",[str class],str.retainCount);
#endif
}

void copyAndMutableCopy(){
    
#if MRC
    ///对象
    NSString *str = [[NSString alloc] initWithFormat:@"testd123456789"];
    NSString *str1 = [str copy];
    NSMutableString *str2 = [str mutableCopy];
    NSLog(@"str:%p,class:%@",str,[str class]);
    NSLog(@"str1:%p,class:%@",str1,[str1 class]);
    NSLog(@"str2:%p,class:%@",str2,object_getClass(str2));
    
    NSMutableString *mstr = [NSMutableString stringWithFormat:@"11"];
    NSLog(@"mstr:%p,class:%@",mstr,object_getClass(mstr));
    [str2 appendString:@"q"];
    [str release];
    [str1 release];
    [str2 release];
#endif
}

void arrayMemory(){
    
    Person *p = [[Person alloc] init];
    ///data 用copy修饰 直接崩溃（copy出来是不可变数组）
    p.data = [NSMutableArray array];
    [p.data addObject:@"a"];
    [p.data addObject:@"b"];
    NSLog(@"%@",p.data);
    [p release];
}

void customObjectCopy(){
    
//    Person *p = [[Person alloc] init];
//    p.name = @"Jentle";
//    p.no = @"12345";
//    p.age = 109;
//    Person *p1 = [p copy];
//    NSLog(@"%@",p1);
//    NSInteger c = p1.age + 1;
//    NSLog(@"%zd",c);
//    [p release];
//    [p1 release];
    
    Student *s = [[Student alloc] init];
    s.payed = YES;
    s.name = @"Jentle";
    s.no = @"4231122334";
    s.age = 18;
    s.data = [NSArray arrayWithObjects:@"A",@"B",@"C",nil].mutableCopy;
    s.rank = 1;
    
    
    Student *s1 = [s copy];
    s1.payed = NO;
    s1.name = @"Zhi";
    NSLog(@"%@",s1);
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        customObjectCopy();
    }
    return 0;
}


