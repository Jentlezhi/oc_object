//
//  main.m
//  RuntimeDemo
//
//  Created by Jentle on 2021/6/4.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Person.h"
#import <objc/message.h>

void test(id object){
    
//    BOOL isKindOf = [object isKindOfClass:[NSObject class]];
//    NSLog(@"isKindOf:%d",isKindOf);
//
//    BOOL isMemberOf = [object isMemberOfClass:[Person class]];
//    NSLog(@"isMemberOf:%d",isMemberOf);
    
    BOOL res1 = [[NSObject class] isKindOfClass:[NSObject class]];
    NSLog(@"res1:%d",res1);//res1:1
    
    BOOL res2 = [[Person class] isKindOfClass:[NSObject class]];
    NSLog(@"res2:%d",res2);//res2:1
//
//    BOOL res2 = [[NSObject class] isMemberOfClass:[NSObject class]];
//    NSLog(@"res2:%d",res2);//res2:0
//
//    BOOL res3 = [[Person class] isKindOfClass:[Person class]];
//    NSLog(@"res3:%d",res3);//res3:0
//
//    BOOL res4 = [[Person class] isMemberOfClass:[Person class]];
//    NSLog(@"res4:%d",res4);//res4:0
//    Person *p = [Person new];
//    NSLog(@"[Person class] == [p class] :%d",[Person class] == [p class]);
//    NSLog(@"%d",[[p class] isMemberOfClass:object_getClass([Person class])]);
//    NSLog(@"%d",[Person isMemberOfClass:object_getClass([Person class])]);
//    NSLog(@"%d",Person == [p class]);
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test(Student.new);
//        NSLog(@"Hello, World!");
        
        
        struct objc_super2 {
            id receiver;//消息接收者，当前对象
            Class current_class;//receiver的Class对象
        };
        struct objc_super2 arg {
            self,
            class_getSuperclass(object_getClass(self))
        }
        objc_msgSendSuper2(arg, @selector(method));
        
    }
    return 0;
}
