//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "Person.h"


@interface ViewController ()


@property(nonatomic, strong) NSString *strongStr;

@property(nonatomic, copy) NSString *copyyStr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        // 第一种场景：用NSString直接赋值
        NSString *originStr1 = [NSString stringWithFormat:@"hello,everyone"];

        _strongStr = originStr1;
        _copyyStr = originStr1;
            
        NSLog(@"第一种场景：用NSString直接赋值");
        NSLog(@"对象地址 对象指针地址  对象的值   ");
        //&是取地址符号，取变量的地址
        NSLog(@"originStr: %p , %p , %@", originStr1, &originStr1, originStr1);
        NSLog(@"strongStr: %p , %p , %@", _strongStr, &_strongStr, _strongStr);
        NSLog(@" copyyStr: %p , %p , %@", _copyyStr, &_copyyStr, _copyyStr);
    }
    
    {
        // 第二种场景：用NSMutableString直接赋值
        NSMutableString *originStr2 = [NSMutableString stringWithFormat:@"hello,everyone"];

        _strongStr = originStr2;
        _copyyStr = originStr2;

        [originStr2 setString:@"hello,QiShare"];
            
        NSLog(@"第二种场景：用NSMutableString直接赋值");
        NSLog(@"对象地址   对象指针地址        对象的值");
        NSLog(@"originStr: %p , %p , %@", originStr2, &originStr2, originStr2);
        NSLog(@"strongStr: %p , %p , %@", _strongStr, &_strongStr, _strongStr);
        NSLog(@" copyyStr: %p , %p , %@", _copyyStr, &_copyyStr, _copyyStr);
    }
    
    {
        // 第三种场景：用NSMutableString点语法赋值
        NSMutableString *originStr3 = [NSMutableString stringWithFormat:@"hello,everyone"];
            
        self.strongStr = originStr3;
        self.copyyStr = originStr3;
            
        [originStr3 setString:@"hello,QiShare"];
            
        NSLog(@"第三种场景：用NSMutableString点语法赋值");
        NSLog(@"               对象地址         对象指针地址        对象的值   ");
        NSLog(@"originStr: %p , %p , %@", originStr3, &originStr3, originStr3);
        NSLog(@"strongStr: %p , %p , %@", _strongStr, &_strongStr, _strongStr);
        NSLog(@" copyyStr: %p , %p , %@", _copyyStr, &_copyyStr, _copyyStr);
    }
    
    {
        
        //两个对象进行“=”操作时，我们操作的是对象的引用
        
        // 第四种场景：用NSString点语法赋值
        NSString *originStr4 = [NSString stringWithFormat:@"hello,everyone"];

        self.strongStr = originStr4;
        self.copyyStr = originStr4;
        
            
        NSLog(@"第三种场景：用NSMutableString点语法赋值");
        NSLog(@"对象地址         对象指针地址        对象的值   ");
        NSLog(@"originStr: %p , %p , %@", originStr4, &originStr4, originStr4);
        NSLog(@"strongStr: %p , %p , %@", _strongStr, &_strongStr, _strongStr);
        NSLog(@" copyyStr: %p , %p , %@", _copyyStr, &_copyyStr, _copyyStr);
        
        NSLog(@"strongStr: %p , %p , %@", _strongStr, &_strongStr, _strongStr);
//        NSLog(@"originStr: %p , %p , %@", originStr4, &originStr4, originStr4);
        
        
    }
    
    {
        //==比较的是两个变量引用是是否为同一个对象
        NSString *a = @"Hello";
        NSString *b = a;
        NSLog(@"a: %p , %p , %@", a, &a, a);
        NSLog(@"b: %p , %p , %@", b, &b, b);
        NSLog(@"a == b -> %d", a == b);
        
        UIButton *i;
        UIView *j;
        
    }
    
}


@end
