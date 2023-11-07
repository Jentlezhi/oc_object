//
//  main.m
//  CommandLineDemo
//
//  Created by Jentle on 2021/11/26.
//

#import <Foundation/Foundation.h>
#import "Person.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *h = @"xxx";
//        Person *p = [Person new];
//        [p saySomething];//-[Person saySomething] - self.name = (null)
        Class cls = [Person class];
//        NSLog(@"%p",cls);
        //void * 无类型指针，可以指向任何类型
        void *clsPointer = &cls;
        /*
         方法调用的实质是objcMsgSend(receiver,sel)
         objcMsgSend的查找是通过内存平移等找到方法
         */
        [(__bridge  id)clsPointer saySomething];//-[Person saySomething] - self.name = <Person: 0x1019058d0>
    }
    return 0;
}


