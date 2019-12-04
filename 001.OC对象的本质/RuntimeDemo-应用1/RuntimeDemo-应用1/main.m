//
//  main.m
//  RuntimeDemo-应用1
//
//  Created by Jentle on 2019/12/4.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Car.h"
#import <objc/runtime.h>
#import <objc/message.h>

void getClass(void);
void setClass(void);
void isClass(void);
void isMetaClass(void);
void allocateClassPair(void);
void getIvar(void);
void getIvars(void);
void allocateClassPair(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        getIvars();
    }
    return 0;
}


void getClass(void) {
    
    ///获取类对象
    Person *p = [[Person alloc] init];
    [p run];//[Person run]
    
    ///object_getClass获取isa的指向
    NSLog(@"%p - %p",object_getClass(p),[Person class]);//0x100002460 - 0x100002460
    NSLog(@"%p - %p",object_getClass([Person class]),[Person class]);//0x100002438 - 0x100002460
}


void setClass(void) {

    ///设置isa指向的Class
    Person *p = [[Person alloc] init];
    NSLog(@"p的isa指向为Person");
    [p run];//[Person run]
    object_setClass(p, [Car class]);
    NSLog(@"p的isa指向为Car");
    [p run];//[Car run]
    object_setClass(p, [Person class]);
    NSLog(@"p的isa指向为Person");
    ((void (*) (id, SEL)) (void *)objc_msgSend)(p,@selector(run));//[Person run]
}

void isClass(void){
    
    ///判断一个oc对象是否为Class
    Person *p = [[Person alloc] init];
    NSLog(@"p is a class : %@",object_isClass(p) ? @"true":@"false");//p is a class : false
    ///[Person class] 类对象也是OC对象
    NSLog(@"[Person class] is a class : %@",object_isClass([Person class]) ? @"true":@"false");
    //[Person class] is a class : true
}
void isMetaClass(void){
    
    ///判断一个class是否为元类
    Person *p = [[Person alloc] init];
    NSLog(@"[p class] is a isMetaClass : %@",class_isMetaClass([p class]) ? @"true":@"false");
    //[p class] is a isMetaClass : false
    /// object_getClass 当参数为类对象时 才能获取元类对象
    Class metaClass = object_getClass([Person class]);
    NSLog(@"metaClass is a isMetaClass : %@",class_isMetaClass(metaClass) ? @"true":@"false");
    //metaClass is a isMetaClass : true
}

void run(id self,SEL _cmd){
    
    NSLog(@"%@ - %@",self,NSStringFromSelector(_cmd));
}
void allocateClassPair(void){
    
    NSString *className = [NSString stringWithFormat:@"JZ%@",@"Dog"];
    ///创建类
    Class cls = objc_allocateClassPair([NSObject class], className.UTF8String, 0);
    
    /*
     class结构
     class_rw_t：方法列表、属性列表、协议列表等，注册完类之后可以继续添加这些属性。
     class_ro_t(只读)：类名、成员变量列表等，注册完类之后就不能再添加成员变量了。
     */
    ///最好在注册类之前添加成员变量和方法
    class_addIvar(cls, "_age", 4, 1, @encode(int));
    class_addIvar(cls, "_weight", 4, 1, @encode(int));
    class_addMethod(cls, @selector(run), (IMP)run, "v@:");
    
    ///注册类
    objc_registerClassPair(cls);
    id instance = [[cls alloc] init];
    [instance setValue:@10 forKey:@"_age"];
    [instance setValue:@160 forKey:@"_weight"];
//    [instance run];
    ((void (*) (id, SEL)) (void *)objc_msgSend)(instance,@selector(run));
    //<JZDog: 0x100701c30> - run
    NSLog(@"instance is a type of : %@",object_getClass(instance));//JZDog
    NSLog(@"instance 's age is a %d, weight is %d",[[instance valueForKey:@"_age"] intValue],[[instance valueForKey:@"_weight"] intValue]);//instance 's age is a 10, weight is 160
    
    objc_disposeClassPair(cls);
    
}


void getIvar(void) {
    
    ///获取成员变量信息
    Ivar ageIvar = class_getInstanceVariable([Person class], "_age");
    NSLog(@"%s - %s",ivar_getName(ageIvar),ivar_getTypeEncoding(ageIvar));
    //_age - i
    Ivar strIvar = class_getInstanceVariable([Person class], "_name");
    NSLog(@"%s - %s",ivar_getName(strIvar),ivar_getTypeEncoding(strIvar));
    //_name - @"NSString"

    ///设置成员变量的值
    Person *p = [[Person alloc] init];
    int tempInt = 123;
    object_setIvar(p, ageIvar, (__bridge id)(*(void **)&tempInt));
    NSLog(@"%d",p.age);
    //123
    
    object_setIvar(p, strIvar, @"Jentle");
    ///获取成员变量的值
    NSString *name = object_getIvar(p, strIvar);
    NSLog(@"name:%@",name);
    //name:Jentle
}

void getIvars(void) {
    
    ///成员变量的数量
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([Person class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        NSLog(@"%s - %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    free(ivars);
}
