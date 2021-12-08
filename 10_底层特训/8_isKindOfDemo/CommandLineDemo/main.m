//
//  main.m
//  CommandLineDemo
//
//  Created by Jentle on 2021/11/26.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Person : NSObject

- (void)sayHello;
+ (void)sayHappy;

@end

@implementation Person

- (void)sayHello{
    NSLog(@"Person say : Hello!!!");
}
+ (void)sayHappy{
    NSLog(@"Person say : Happy!!!");
}

@end

void isKindOfDemo(void){
    
    //isKindOfClass
//    Person *p = [Person new];
//    const char *clsName = object_getClassName(p);
//    Class mateCls = objc_getMetaClass(clsName);
//    BOOL re1 = [(id)[Person class] isKindOfClass:mateCls];
//    NSLog(@"re1 = %d",re1);//re1 = 1
    
    NSObject *obj = [NSObject new];
    const char *objcClsName = object_getClassName(obj);
    Class objMataCls = objc_getMetaClass(objcClsName);
    BOOL re2 = [(id)[Person class] isKindOfClass:objMataCls];
    NSLog(@"re2 = %d",re2);//re1 = 1
    
    
    
//    BOOL re1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];       //
//    BOOL re2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];     //
//    BOOL re3 = [(id)[Person class] isKindOfClass:[Person class]];       //
//    BOOL re4 = [(id)[Person class] isMemberOfClass:[Person class]];     //
//    NSLog(@"\n re1 :%hhd\n re2 :%hhd\n re3 :%hhd\n re4 :%hhd\n",re1,re2,re3,re4);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        isKindOfDemo();
    }
    return 0;
}
