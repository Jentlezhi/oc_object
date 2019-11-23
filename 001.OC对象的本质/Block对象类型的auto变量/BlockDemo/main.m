//
//  main.m
//  BlockDemo
//
//  Created by Jentle on 2019/11/20.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

typedef void(^Block)(void);

void ARCEnv(){
    
        {///作用域
            Person *p = [[Person alloc] init];
            p.age = 10;
            Block block = ^{
                NSLog(@"----%d",p.age);
            };
            block();
            ///此时Person没有被释放
            NSLog(@"未离开block所在的作用域---------");
        }///作用域
        ///此时Person已经被释放
        NSLog(@"离开block所在的作用域---------");
}

//void MRCEnv(){
//
//    {///作用域
//        Person *p = [[Person alloc] init];
//        p.age = 10;
//        Block block = ^{
//            NSLog(@"----%d",p.age);
//        };
//        ///__NSStackBlock__
//        NSLog(@"block - class:%@",[block class]);
//        block();
//        NSLog(@"调用release之前---------");
////        [p release];///p立即被释放了
//        NSLog(@"调用release之后---------");
//        NSLog(@"未离开block所在的作用域---------");
////        [block release];
//    }///作用域
//    NSLog(@"离开block所在的作用域---------");
//}
//
//void MRCEnvWithCopy(){
//
//    {///作用域
//        Person *p = [[Person alloc] init];
//        p.age = 10;
//        Block block = [^{
//            NSLog(@"----%d",p.age);
//        } copy];
//        ///__NSStackBlock__
//        NSLog(@"block - class:%@",[block class]);
//        block();
//        NSLog(@"调用release之前---------");
////        [p release];///p没有被释放
//        NSLog(@"调用release之后---------");
//        NSLog(@"未离开block所在的作用域---------");
////        [block release];
//    }///作用域
//    NSLog(@"离开block所在的作用域---------");
//}
//
//void ARCEnvWithWeak(){
//
//    Block block;
//    {///作用域
//        Person *p = [[Person alloc] init];
//        p.age = 10;
//        __weak Person *weakPerson = p;
//        block = ^{
//            NSLog(@"----%d",weakPerson.age);
//        };
//        ///__NSStackBlock__
//        NSLog(@"block - class:%@",[block class]);
//        block();
//        NSLog(@"未离开block所在的作用域---------");
//    }///作用域
//    NSLog(@"离开block所在的作用域---------");
//}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
       ARCEnv();
    }
    return 0;
}

