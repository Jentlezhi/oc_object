//
//  main.m
//  SetterDemo
//
//  Created by Jentle on 2021/11/23.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
// 只有把类定义到main.m文件中，命令(xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m -o main64.cpp)才可以查看Person属性的setter和getter的C++实现
@interface Person: NSObject
{
    @public
    NSString *name;
    int age;
}
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, copy) NSString *others;
- (void)sayHello;
+ (void)sayHappy;
@end

@implementation Person

- (void)sayHello {
    NSLog(@"Hello!");
}
+ (void)sayHappy {
    NSLog(@"Happy!");
}

@end
/*
 * 获取对象的方法
 */
void copyMethodList(id instance){
    unsigned int count = 0;
    Method *methods = class_copyMethodList([instance class], &count);
    for (int i = 0; i < count; i++) {
        Method m = methods[i];
        NSLog(@"%@",NSStringFromSelector(method_getName(m)));
    }
    /*
     2021-11-28 11:33:33.884538+0800 SetterDemo[41556:2751392] sayHello
     2021-11-28 11:33:33.884906+0800 SetterDemo[41556:2751392] .cxx_destruct
     2021-11-28 11:33:33.884951+0800 SetterDemo[41556:2751392] others
     2021-11-28 11:33:33.884992+0800 SetterDemo[41556:2751392] setOthers:
     2021-11-28 11:33:33.885015+0800 SetterDemo[41556:2751392] sex
     2021-11-28 11:33:33.885037+0800 SetterDemo[41556:2751392] setSex:
     */
}

void getMateClass(void){
    
    Method method = class_getClassMethod([Person class], @selector(sayHappy));
    NSLog(@"method = %@",NSStringFromSelector(method_getName(method)));
    //method = sayHappy
    Class cls = objc_getMetaClass("Person");
    Method mateMethod = class_getInstanceMethod(cls, @selector(sayHappy));
    NSLog(@"mateMethod = %@",NSStringFromSelector(method_getName(mateMethod)));
    //mateMethod = sayHappy
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        copyMethodList([Person new]);
//        NSLog(@"------------------");
//        Class cls = objc_getMetaClass(object_getClassName([Person class]));
//        copyMethodList(cls);
        getMateClass();
    }
    return 0;
}

