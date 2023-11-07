//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "Person.h"

typedef void(^Block)(void);

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self block5];
}

- (void)block1 {
    
    __block int a = 10;
    void(^myBlock)(void) = ^{
        a = 20;
    };
    myBlock();
    NSLog(@"a = %d",a);//a = 20
}

- (void)block2 {
    {
        Block block;//强指针
        {
            Person *p = [Person new];
            p.age = 10;
            block = ^{
                NSLog(@"%d",p.age);
            };
        }//这行结束Person不会被销毁
        NSLog(@"%@",[block class]);//__NSMallocBlock__
        NSLog(@"-- Person - end--");
    }//block的作用域
    NSLog(@"--block - end--");
}

- (void)block3 {
    
    //p 是auto变量
    Person *p = [Person new];
    p.age = 10;
    p.name = @"Jen";
    Block myBlock = ^{
        //这里捕获的是Person *，block按原类型捕获
        NSLog(@"%d",p.age);
        p.name = @"Jentle";
        NSLog(@"%s",__func__);
    };
    NSLog(@"%@",p.name);//Jen
    myBlock();
    NSLog(@"%@",p.name);//Jentle
}

- (void)block4 {
    __weak Person *p = [Person new];
    p.block = ^{
        NSLog(@"%s",__func__);
    };
    NSLog(@"%@",[p.block class]);
    NSLog(@"%@",p.name);
    p.block();//野指针错误
}

void (^myBlock)(void);

void test1(void){
    int a = 10;
    myBlock = ^{
        NSLog(@"%d",a);
        NSLog(@"%s",__func__);
    };
    NSLog(@"test1 - %@",[myBlock class]);//test1 - __NSStackBlock__
}

void test2(void){
    NSLog(@"test2 - %@",[myBlock class]);//test1 - test2 - (null)
    myBlock();///崩溃
}

- (void)block5 {
    test1();
//    test2();
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}


@end
