//
//  ViewController.m
//  class&metaclass
//
//  Created by Jentle on 2021/10/14.
//

#import "ViewController.h"
#import "Person.h"
#import "Student.h"
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

int sum(int a, int b){
    
    return a + b;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self structOfClass];
    NSLog(@"------------------------");
    [self super_class];
    NSLog(@"------------------------");
    [self mate_class];
//    [self mateClass];
//    NSLog(@"------------------------");
//    NSLog(@"test break point1");
//    NSLog(@"test break point2");
//    NSLog(@"test break point3");
//    int res = sum(2, 3);
//    NSLog(@"res = %d",res);
}

- (void)mateClass {
    
    //类对象
    Person *p = [Person new];
    Class class1 = [p class];
    Class class2 = [Person class];
    Class class3 = object_getClass(p);
    Class class4 = object_getClass(class3);//类所属类为元类
    Class class5 = object_getClass(class4);//元类对象所属类为根元类
    Class class6 = object_getClass(class5);//根元类的所属类为自己
    
    NSLog(@"class1 = %p",class1);//class1 = 0x108c89548
    NSLog(@"class2 = %p",class2);//class2 = 0x108c89548
    NSLog(@"class3 = %p",class3);//class3 = 0x108c89548
    NSLog(@"class4 = %p",class4);//class4 = 0x108c89520
    NSLog(@"class5 = %p",class5);//class5 = 0x7fff80030638
    NSLog(@"class6 = %p",class6);//class6 = 0x7fff80030638
}


- (void)structOfClass {
    //Student->Person->NSObject
    Student *s = [Student alloc];
    Person *p = [Person alloc];
    NSObject *n = [NSObject alloc];
}

- (void)super_class {
    
    Person *p = [Person alloc];
    
    Student *s = [Student alloc];
    
    Class sSuperClass = class_getSuperclass([s class]);
    
    NSLog(@"sSuperClass = %@",sSuperClass);
    
    Class pClass = [p class];
    NSLog(@"pClass = %@",pClass);
    
    Class pSuperClass = class_getSuperclass([p class]);
    NSLog(@"pSuperClass = %@",pSuperClass);
    
    Class nSuperClass = class_getSuperclass(pSuperClass);
    NSLog(@"nSuperClass = %@",nSuperClass);
    
//    Class class = object_getClass(p);
//    NSLog(@"class = %p",class);
//    NSLog(@"class = %p",class);
}

- (void)mate_class {
    
    Person *p = [[Person alloc] init];
    Class class = [p class];
    NSLog(@"class = %@,address = %p",class,class);
    Class mateClass = objc_getMetaClass("Person");
    NSLog(@"mateClass = %@,address = %p",mateClass,mateClass);
}

- (void)dynamic_create_class {
    
    /*
     objc_allocateClassPair  分配空间,创建类(仅在 创建之后,注册之前 能够添加成员变量)
     objc_registerClassPair  注册一个类(注册后方可使用该类创建对象)
     */
    Class Student = objc_allocateClassPair([NSObject class], "Student", 0);
    NSLog(@"%@",Student);
//    class_addIvar(Student, "name", sizeof(id), log2(sizeof(id)), @encode(id));
    objc_registerClassPair(Student);
    
//    class_addIvar(Student, "name", sizeof(id), log2(sizeof(id)), @encode(id));//[<Student 0x600001b303c0> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key name.'
    
    id s = [[Student alloc] init];
    [s setValue:@"Jentle" forKey:@"name"];
    NSLog(@"name = %@",[s valueForKey:@"name"]);
    
}


@end
