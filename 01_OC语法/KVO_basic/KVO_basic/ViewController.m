//
//  ViewController.m
//  KVO_basic
//
//  Created by Jentle on 2019/9/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modifyIsa];
}

- (void)printMethods:(Class)cls description:(NSString *)des {
    
    unsigned int outCount;
    Method *methods = class_copyMethodList(cls, &outCount);
    NSMutableString *methodsName = @"".mutableCopy;
    [methodsName appendString:des];
    [methodsName appendString:@"  "];
    [methodsName appendString:NSStringFromClass(cls)];
    [methodsName appendString:@"  "];
    for (int i = 0; i < outCount; i ++) {
        Method method = methods[i];
        NSString *methodName = NSStringFromSelector(method_getName(method));
        [methodsName appendString:methodName];
        [methodsName appendString:@" "];
    }
    NSLog(@"%@",methodsName);
    free(methods);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self learnKVOObserve];
//    [self learnKVOMethods];
    [self callKVOHandly];
    
}

- (void)learnKVOMethods {
    
    Person *p = Person.new;
    p.age = 1;
    
    Person *p0 = Person.new;
    p0.age = 2;
    
    [self printMethods:object_getClass(p) description:@"p添加监听前"];
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    ///p->isa (Class) $1 = Person
    [p addObserver:self forKeyPath:@"age" options:options context:(__bridge void * _Nullable)(@{@"value":@"100"})];
    /*
     object_getClass:获取运行时类型
     [p class]: 获取静态类型
     */
    [self printMethods:object_getClass(p) description:@"p添加监听后"];
//    [p removeObserver:self forKeyPath:@"age"];
    
    ///[p class]:Person
    /*
     apple不希望将NSKVONotifyin_Person类暴露出来，并且不希望我们知道NSKVONotifyin_Person内部实现，
     所以在内部重写了class类，直接返回Person类

     */
    NSLog(@"[p class]:%@",NSStringFromClass([p class]));
    NSLog(@"object_getClass(p):%@",object_getClass(p));
}

- (void)learnKVOObserve {
    
    Person *p = Person.new;
    p.age = 1;
    
    Person *p0 = Person.new;
    p0.age = 2;
    NSLog(@"p添加kvo之前：p->Class=%@,p0->Class=%@",object_getClass(p),object_getClass(p0));
    
    /*
     SEL : 类成员方法的指针，但不同于C语言中的函数指针，函数指针直接保存了方法的地址，但SEL只是方法编号。
     
     IMP:一个函数指针,保存了方法的地址。
     */
    NSLog(@"添加kvo之前：%p",[p methodForSelector:@selector(setAge:)]);
    NSLog(@"添加kvo之前：%p",[p0 methodForSelector:@selector(setAge:)]);
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    ///p->isa (Class) $1 = Person
    [p addObserver:self forKeyPath:@"age" options:options context:(__bridge void * _Nullable)(@{@"value":@"100"})];
    NSLog(@"p添加kvo之后：p->Class=%@,p0->Class=%@",object_getClass(p),object_getClass(p0));
    
    NSLog(@"添加kvo之后：p:%p",[p methodForSelector:@selector(setAge:)]);
    NSLog(@"添加kvo之后：p0:%p",[p0 methodForSelector:@selector(setAge:)]);
    ///p->isa (Class) $2 = NSKVONotifying_Person(Person的子类)
    p.age = 100;
    p.age = 200;
    [p removeObserver:self forKeyPath:@"age"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSDictionary *contextDict = (__bridge NSDictionary *)context;
    NSString *value = [contextDict valueForKey:@"value"];
    NSLog(@"value:%@",value);
    NSLog(@"监听到%@的%@改变：%@,context=%@",object,keyPath,change,context);
}

- (void)callKVOHandly {
    
    Person *p = Person.new;
//    p.age = 1;
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    ///p->isa (Class) $1 = Person
    [p addObserver:self forKeyPath:@"age" options:options context:(__bridge void * _Nullable)(@{@"value":@"100"})];
    ///手动触发kvo
    [p willChangeValueForKey:@"age"];
//    p.age = 5;
    [p didChangeValueForKey:@"age"];
    
}

- (void)modifyIsa {
    
    Student *s = Student.new;
    Person *p = Person.new;
    //修改isa的指向
    object_setClass(p, [s class]);
    [p test];//Student - test
}


@end
