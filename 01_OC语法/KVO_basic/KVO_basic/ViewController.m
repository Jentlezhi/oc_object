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
#import "Account.h"

@interface ViewController ()

@property(strong, nonatomic) Account *account;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self modifyIsa];
    [self observeAccount];
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
    
    [self learnKVOObserve];
//    [self learnKVOMethods];
//    [self callKVOHandly];
    
//    self.account.balance = 3;
//    self.account.interestRate = 4;
//    [self observeCollection];
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

- (void)observeCollection {
    
    Person *p = Person.new;
    [p addObserver:self forKeyPath:@"array" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld  context:NULL];
    NSMutableArray *kvoArray = [p mutableArrayValueForKey:@"array"];
    [kvoArray addObject:@"a"];
    [kvoArray addObject:@"b"];
    
}

- (void)learnKVOObserve {
//    Person *p = Person.new;
//    [p addObserver:self forKeyPath:@"fullName" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
//    p.firstName = @"Zhi";
//    p.lastName = @"Jentle";
//    NSLog(@"fullName = %@",p.fullName);
//    [p removeObserver:self forKeyPath:@"fullName"];
    
    
    Person *p = Person.new;
    p.age = 1;

    Person *p0 = Person.new;
    p0.age = 2;
//    NSLog(@"p添加kvo之前：p->Class=%@,p0->Class=%@",object_getClass(p),object_getClass(p0));
//
//    /*
//     SEL : 类成员方法的指针，但不同于C语言中的函数指针，函数指针直接保存了方法的地址，但SEL只是方法编号。
//
//     IMP:一个函数指针,保存了方法的地址。
//     */
//    NSLog(@"添加kvo之前：%p",[p methodForSelector:@selector(setAge:)]);
//    NSLog(@"添加kvo之前：%p",[p0 methodForSelector:@selector(setAge:)]);
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    ///p->isa (Class) $1 = Person
    [p addObserver:self forKeyPath:@"age" options:options context:(__bridge void * _Nullable)(@{@"value":@"100"})];
//    NSLog(@"p添加kvo之后：p->Class=%@,p0->Class=%@",object_getClass(p),object_getClass(p0));
//
//    NSLog(@"添加kvo之后：p:%p",[p methodForSelector:@selector(setAge:)]);
//    NSLog(@"添加kvo之后：p0:%p",[p0 methodForSelector:@selector(setAge:)]);
//    ///p->isa (Class) $2 = NSKVONotifying_Person(Person的子类)
//    p.age = 100;
//    [p setValue:@(100) forKey:@"age"];
//    p.age = 200;
//    [p removeObserver:self forKeyPath:@"age"];
//    [p callObserHandly];
    
    [p addObserver:self forKeyPath:@"weight" options:options context:NULL];
//    p->weight = 180;
    [p setValue:@180 forKey:@"weight"];
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

- (void)observeAccount {
    Account *account = [Account new];
    account.balance = 1;
    account.interestRate = 2;
    self.account = account;
    [self registerAsObserverForAccount:account];
}

static void *PersonAccountInterestRateContext = &PersonAccountInterestRateContext;
static void *PersonAccountBalanceContext = &PersonAccountBalanceContext;

- (void)registerAsObserverForAccount:(Account*)account {
    [account addObserver:self
              forKeyPath:@"balance"
                 options:(NSKeyValueObservingOptionNew |
                          NSKeyValueObservingOptionOld)
                 context:PersonAccountBalanceContext];
 
    [account addObserver:self
              forKeyPath:@"interestRate"
                 options:(NSKeyValueObservingOptionNew |
                          NSKeyValueObservingOptionOld)
                  context:PersonAccountInterestRateContext];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath
//                      ofObject:(id)object
//                        change:(NSDictionary *)change
//                       context:(void *)context {
// 
//    if (context == PersonAccountBalanceContext) {
//        // Do something with the balance…
//        NSLog(@"监听到%@的%@改变：%@",object,keyPath,change);
//    } else if (context == PersonAccountInterestRateContext) {
//        // Do something with the interest rate…
//        NSLog(@"监听到%@的%@改变：%@",object,keyPath,change);
//    } else {
//        // Any unrecognized context must belong to super
//        [super observeValueForKeyPath:keyPath
//                             ofObject:object
//                               change:change
//                               context:context];
//    }
//}

- (void)modifyIsa {
    
    Student *s = Student.new;
    Person *p = Person.new;
    //修改isa的指向
    object_setClass(p, [s class]);
    [p test];//Student - test
}


@end
