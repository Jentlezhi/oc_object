//
//  main.m
//  KCObjcBuild
//
//  Created by cooci on 2021/1/5.


// KC 重磅提示 调试工程很重要 源码直观就是爽
// ⚠️编译调试不能过: 请你检查以下几小点⚠️
// ①: enable hardened runtime -> NO
// ②: build phase -> denpendenice -> objc
// 爽了之后,还来一个 👍

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
#import <objc/runtime.h>
#import <objc/message.h>

/*
 class_data_bits_t
 
 class_rw_t
 
 class_ro_t
 */

//void isKindOfDemo(void){
//    BOOL re1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];       //
//    BOOL re2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];     //
//    BOOL re3 = [(id)[Person class] isKindOfClass:[Person class]];       //
//    BOOL re4 = [(id)[Person class] isMemberOfClass:[Person class]];     //
//    NSLog(@"\n re1 :%hhd\n re2 :%hhd\n re3 :%hhd\n re4 :%hhd\n",re1,re2,re3,re4);
//}

void instanceMethod_classToMetaclass(Class pClass){
    
    const char *className = class_getName(pClass);
    Class metaClass = objc_getMetaClass(className);
    
    Method method1 = class_getInstanceMethod(pClass, @selector(sayHello)); // 1
    Method method2 = class_getInstanceMethod(metaClass, @selector(sayHello)); // 0

    Method method3 = class_getInstanceMethod(pClass, @selector(sayHappy)); // 0
    Method method4 = class_getInstanceMethod(metaClass, @selector(sayHappy));// 1
    
    NSLog(@"%s===%p-%p-%p-%p",__func__,method1,method2,method3,method4);
}


void instanceSize(void){
    
    Person *p = [Person alloc];
//    p.name = @"Jentle";
//    p.age = 18;
//    p.sex = 1;
//    p.address = @"BeiJindHaidian";
//    
    Student *s = [Student alloc];
//    //class_data_bits_t *
    size_t size = class_getInstanceSize([p class]);
    NSLog(@"size = %zu",size);
    
}

struct StructA {
    double a;
    char b;
    int c;
    short d;
} structa;

struct StructB {
    double a;
    int c;
    char b;
    short d;
} structb;

void instanceAndClassMethod(void) {
    
    Method method1 = class_getInstanceMethod([Person class], @selector(instanceMethod));
    Method method2 = class_getInstanceMethod(objc_getMetaClass("Person"), @selector(instanceMethod));
    Method method3 = class_getInstanceMethod([Person class], @selector(classMethod));
    Method method4 = class_getInstanceMethod(objc_getMetaClass("Person"), @selector(classMethod));
    NSLog(@"method1 = %p",method1);//method1 = 0x100008090
    NSLog(@"method2 = %p",method2);//method2 = 0x0
    NSLog(@"method3 = %p",method3);//method3 = 0x0
    NSLog(@"method4 = %p",method4);//method4 = 0x100008028
    /*
     总结:
     1.对象方法存储在类对象里
     2.类方法存储在元类对象里
     */
}

void methodImp(void){
    
    IMP imp1 = class_getMethodImplementation([Person class], @selector(instanceMethod));
    IMP imp2 = class_getMethodImplementation(objc_getMetaClass("Person"), @selector(instanceMethod));
    IMP imp3 = class_getMethodImplementation([Person class], @selector(classMethod));
    IMP imp4 = class_getMethodImplementation(objc_getMetaClass("Person"), @selector(classMethod));
    NSLog(@"imp1 = %p",imp1);//imp1 = 0x100003c20
    NSLog(@"imp2 = %p",imp2);//imp2 = 0x7fff204685c0 imp2    IMP    (libobjc.A.dylib`_objc_msgForward)    0x00007fff204685c0
    NSLog(@"imp3 = %p",imp3);//imp3 = 0x7fff204685c0 imp2    IMP    (libobjc.A.dylib`_objc_msgForward)    0x00007fff204685c0
    NSLog(@"imp4 = %p",imp4);//imp4 = 0x100003c50
    /*
     总结：
     class_getMethodImplementation的底层实现：
     IMP class_getMethodImplementation(Class cls, SEL sel)
     {
         IMP imp;

         if (!cls  ||  !sel) return nil;

         lockdebug_assert_no_locks_locked_except({ &loadMethodLock });

         imp = lookUpImpOrNilTryCache(nil, sel, cls, LOOKUP_INITIALIZE | LOOKUP_RESOLVER);

         // Translate forwarding function to C-callable external version
         if (!imp) {
             return _objc_msgForward;
         }

         return imp;
     }
     如果没有找到imp，就返回_objc_msgForward
     */
}

void classMethod(void)  {
    
    Method method1 = class_getClassMethod([Person class], @selector(instanceMethod));
    Method method2 = class_getClassMethod(objc_getMetaClass("Person"), @selector(instanceMethod));
    Method method3 = class_getClassMethod([Person class], @selector(classMethod));
    Method method4 = class_getClassMethod(objc_getMetaClass("Person"), @selector(classMethod));
    NSLog(@"method1 = %p",method1);//method1 = 0x0
    NSLog(@"method2 = %p",method2);//method2 = 0x0
    NSLog(@"method3 = %p",method3);//method3 = 0x100008310
    NSLog(@"method4 = %p",method4);//method4 = 0x100008310
}

void structSize(void){
    NSLog(@"StructA = %lu",sizeof(structa));
    NSLog(@"StructB = %lu",sizeof(structb));
}

void otherInstanceSize(void){
    Person *p = [Person alloc];
    Class mateClass = objc_getMetaClass("Person");
    NSLog(@"%p",p);
    NSLog(@"mateClass = %p",mateClass);
}

void method_swizzing(void) {
    
    Student *s = [Student new];
//    [s printAddress];
    [Person isKindOfClass:[Person class]];
    Person *p = [Person new];
    [p personInstanceMethod];
//    Method m1 =  class_getInstanceMethod([s class], @selector(personInstanceMethod));
//    NSLog(@"%@",m1);
}

void metaClassInherit(void){
    
    Student *s = [Student new];
    Class sClass = object_getClass(s);
    Class sMateClass = object_getClass(sClass);
    NSLog(@"sMateClass = %@ ... address = %p",sMateClass,sMateClass);//sMateClass = Student ... address = 0x100008d00
    
    Person *p = [Person new];
    Class pClass = object_getClass(p);
    Class pMateClass = object_getClass(pClass);
    NSLog(@"pMateClass = %@ ... address = %p",pMateClass,pMateClass);//pMateClass = Person ... address = 0x100008cb0
    
    //查看sMateClass的继承关系
    Class xClass = class_getSuperclass(sMateClass);
    NSLog(@"xClass = %@ ... address = %p",xClass,xClass);//xClass = Person ... address = 0x100008cb0
    
//    Class sMateClass = class_getSuperclass([s class]);
//    NSLog(@"sSuperClass = %@ ... address = %p",sMateClass,&sMateClass);
    
    
    
//    Class pMateClass = class_getSuperclass([p class]);
//    NSLog(@"pMateClass = %@ ... address = %p",pMateClass,&pMateClass);
//
//    Class pMetaClass = class_getSuperclass([s class]);
//    NSString *pMetaClassName = NSStringFromClass(pMetaClass);
//    NSLog(@"pMetaClassName = %@ address = %p",pMetaClassName,&pMetaClassName);
    
    NSObject *obj = [NSObject new];
    Class objClass = object_getClass(obj);
    NSLog(@"objClass = %@ address = %p",objClass,objClass);
    //objClass = NSObject address = 0x100372140
    Class objMateClass = object_getClass(objClass);
    NSLog(@"objMateClass = %@ address = %p",objMateClass,objMateClass);
    //objMateClass = NSObject address = 0x1003720f0
    Class objMateMateClass = object_getClass(objMateClass);
    NSLog(@"objMateMateClass = %@ address = %p",objMateMateClass,objMateMateClass);
    //objMateMateClass = NSObject address = 0x1003720f0
    
    id superClass = class_getSuperclass(NSObject.class);
    NSLog(@"superClass = %@ superClass = %p",superClass,superClass);
    //superClass = (null) superClass = 0x0
}

void isKindOfDemo(void){
    
    //isKindOfClass
    Person *p = [Person new];
    BOOL re1 = [p isKindOfClass:[Person class]];
    NSLog(@"re1 = %d",re1);//re1 = 1
    
    BOOL re2 = [p isKindOfClass:[Student class]];
    NSLog(@"re2 = %d",re2);//re2 = 0
    
    BOOL re3 = [p isKindOfClass:[NSObject class]];
    NSLog(@"re3 = %d",re3);//re3 = 1
    
//    NSObject *obj = [NSObject new];
//    const char *objcClsName = object_getClassName(obj);
//    Class objMataCls = objc_getMetaClass(objcClsName);
//    BOOL re2 = [(id)[Person class] isKindOfClass:objMataCls];
//    NSLog(@"re2 = %d",re2);//re2 = 1
    
    
    
//    BOOL re1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];       //
//    BOOL re2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];     //
//    BOOL re3 = [(id)[Person class] isKindOfClass:[Person class]];       //
//    BOOL re4 = [(id)[Person class] isMemberOfClass:[Person class]];     //
//    NSLog(@"\n re1 :%hhd\n re2 :%hhd\n re3 :%hhd\n re4 :%hhd\n",re1,re2,re3,re4);
}

void isMemberOfClassDemo(void){
    
//    Person *p = [Person new];
//    const char *clsName = object_getClassName(p);
//    Class mateCls = objc_getMetaClass(clsName);
//    BOOL re1 = [(id)[Person class] isMemberOfClass:mateCls];
//    NSLog(@"re1 = %d",re1);//re1 = 1
//
//    NSObject *obj = [NSObject new];
//    const char *objcClsName = object_getClassName(obj);
//    Class objMataCls = objc_getMetaClass(objcClsName);
//    BOOL re2 = [(id)[Person class] isMemberOfClass:objMataCls];
//    NSLog(@"re2 = %d",re2);//re1 = 0
    
    Person *p = [Person new];
    BOOL re1 = [p isMemberOfClass:[Person class]];
    NSLog(@"re1 = %d",re1);//re1 = 1
    
    BOOL re2 = [p isMemberOfClass:[Student class]];
    NSLog(@"re2 = %d",re2);//re2 = 0
    
    BOOL re3 = [p isMemberOfClass:[NSObject class]];
    NSLog(@"re3 = %d",re3);//re3 = 0
}

void cache_test(void){
    
    Person *p = [Person new];
    Class pClass = [p class];
    NSLog(@"%@",pClass);
    NSLog(@"%@",p);
    [p sayHello];
    [p sayGoodBye];
    NSLog(@"%s",__func__);
}

int main(int argc, const char * argv[]) {
//    instanceAndClassMethod();
//    classMethod();
//    otherInstanceSize();
//    instanceSize();
//    method_swizzing();
//    metaClassInherit();
//    isKindOfDemo();
//    NSLog(@"Hello World!");
//    Person  *p =  [Person new];
//    instanceMethod_classToMetaclass([p class]);
//    isMemberOfClassDemo();
    cache_test();
    return 0;
}




