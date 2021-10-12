//
//  main.m
//  RuntimeDemo
//
//  Created by Jentle on 2021/6/4.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Person.h"

void test(id object){
    
    BOOL isKindOf = [object isKindOfClass:[NSObject class]];
    NSLog(@"isKindOf:%d",isKindOf);
    
    BOOL isMemberOf = [object isMemberOfClass:[Person class]];
    NSLog(@"isMemberOf:%d",isMemberOf);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test(Student.new);
        NSLog(@"Hello, World!");
    }
    return 0;
}
