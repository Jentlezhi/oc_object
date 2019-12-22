//
//  main.m
//  MRCDemo
//
//  Created by Jentle on 2019/12/21.
//  Copyright © 2019 Jentle. All rights reserved.
//  关闭自动内存管理

#import <Foundation/Foundation.h>
#import "objc/message.h"

void taggedPointerRetainCount(){
    
    NSString *str = [[NSString alloc] initWithFormat:@"test"];
    ///taggedPointer,retainCount为-1；
    NSLog(@"%@ - %zd",[str class],str.retainCount);
}

void copyAndMutableCopy(){
    
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
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        copyAndMutableCopy();
    }
    return 0;
}


