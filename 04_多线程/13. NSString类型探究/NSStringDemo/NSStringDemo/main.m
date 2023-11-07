//
//  main.m
//  NSStringDemo
//
//  Created by Jentle-Zhi on 2023/8/8.
//

#import <Foundation/Foundation.h>
#import "MyTestClass.h"

//宏定义
#define HXLog(_var) ({ NSString *name = @#_var; NSLog(@"变量名=%@，类型=%@， 地址=%p，引用计数=%ld，值=%@", name, [_var class], _var,[_var retainCount], _var); })

void test() {
    NSString *a0 = [[NSString alloc] init];//__NSCFConstantString retainCount = -1
    NSString *a1 = @"ABC";//__NSCFConstantString retainCount = -1
    NSString *a2 = [NSString stringWithString:@"ABC"];//__NSCFConstantString retainCount = -1
    NSString *a3 = [[NSString alloc] initWithString:@"ABC"];//__NSCFConstantString retainCount = -1
    NSString *a4 = [[NSString alloc] initWithString:a0];//__NSCFConstantString retainCount = -1

    NSString *a5 = [[NSString alloc] initWithFormat:@"ABCDEFGHIJKLMN"];//__NSCFString retainCount = 1
    NSString *a6 = [[NSString alloc] initWithFormat:@"ABC"];//NSTaggedPointerString retainCount = -1
    NSString *a7 = [NSString stringWithFormat:@"ABC"];//NSTaggedPointerString retainCount = -1
    NSString *a8 = [NSString stringWithFormat:a5];//__NSCFString retainCount = 1

    HXLog(a0);
    HXLog(a1);
    HXLog(a2);
    HXLog(a3);
    HXLog(a4);
    HXLog(a5);
    HXLog(a6);
    HXLog(a7);
    HXLog(a8);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *str1 = @"ABC";
        NSString *str2 = [str1 copy];
        NSLog(@"str1 = %@; str2 = %@",str1,str1);//str1 = ABC; str2 = ABC
        NSLog(@"str1 地址 = %p; str2 地址 = %p",str1,str2);//str1 地址 = 0x100004038; str2 地址 = 0x100004038
        NSLog(@"str1 变量的地址 = %p；str2 变量的地址 = %p",&str1, &str2);//str1 变量的地址 = 0x7ff7bfeff278；str2 变量的地址 = 0x7ff7bfeff270
        NSLog(@"autoreleasepool_push");
        @autoreleasepool {
            MyTestClass *class = [[MyTestClass new] autorelease];
        }
        NSLog(@"autoreleasepool_pop");
    }
    return 0;
}
