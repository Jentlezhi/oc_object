//
//  main.m
//  KCObjcBuild
//
//  Created by cooci on 2021/1/5.

/**
 KC 重磅提示 调试工程很重要 源码直观就是爽
 ⚠️编译调试不能过: 请你检查以下几小点⚠️
 ①: enable hardened runtime -> NO
 ②: build phase -> denpendenice -> objc
 ③: team 选择 None
 爽了之后,还来一个 👍
 */


#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+MyCategory.h"
#import <objc/message.h>


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Person *p = [Person new];
        [p say1];//[Person say1]
        Class cls = [Person class];
        NSLog(@"%p",cls);
        //void * 无类型指针，可以指向任何类型
        void *clsPointer = &cls;
        /*
         方法调用的实质是objcMsgSend(receiver,sel)
         objcMsgSend的查找是通过内存平移等找到方法
         */
        [(__bridge  id)clsPointer say1];//[Person say1]
        NSLog(@"iOS 高级之美");
    }
    return 0;
}

__attribute__((constructor))
static void beforeMain(void) {
    NSLog(@"beforeMain");
}
