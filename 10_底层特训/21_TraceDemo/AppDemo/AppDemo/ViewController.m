//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "FBKVOController.h"
#import "Person.h"
#include <stdint.h>
#include <stdio.h>
#include <sanitizer/coverage_interface.h>
#import <dlfcn.h>
#import <libkern/OSAtomic.h>

@interface ViewController ()

@property(assign, nonatomic) int age;


@end

@implementation ViewController

+ (void)load {
    NSLog(@"load");
}

+ (void)myClassMethod {
    
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *v;
    [v setNeedsDisplay];
//    NSThread *thread = [[NSThread alloc] initWithBlock:^{
//        NSLog(@"----");
//    }];
//    [thread start];
}

/*
void (^block)(void) = ^(){
    NSLog(@"block");
};

void func(void){
    
    NSLog(@"func");
    block();
}

- (void)myInstanceMethod {
    
    NSLog(@"%s",__func__);
    self.age = 10;
    func();
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self myInstanceMethod];
}
*/

//定义原子队列
static OSQueueHead symbolList = OS_ATOMIC_QUEUE_INIT;
//定义符号结构体
typedef struct{
    void * pc;
    void * next;
} SYNode;

void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
                                                    uint32_t *stop) {
  static uint32_t N;
  if (start == stop || *start) return;
  printf("INIT: %p %p\n", start, stop);
  for (uint32_t *x = start; x < stop; x++)
    *x = ++N;
}

void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
//  if (!*guard) return;
  void *PC = __builtin_return_address(0);
    Dl_info info;
    dladdr(PC, &info);
    printf("%s\n", info.dli_sname);
    SYNode *node = malloc(sizeof(SYNode));
    *node = (SYNode){PC,NULL};
    //结构体入栈
    OSAtomicEnqueue(&symbolList, node, offsetof(SYNode, next));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSMutableArray *array = @[].mutableCopy;
    while (YES) {
        SYNode *node = OSAtomicDequeue(&symbolList, offsetof(SYNode, next));
        if (node == NULL) {
            break;
        }
        Dl_info info;
        dladdr(node->pc, &info);
        NSString *sname = [NSString stringWithUTF8String:info.dli_sname];
        bool isObjc = [sname hasPrefix:@"-["] || [sname hasPrefix:@"+["];
        sname = isObjc ? sname : [@"_" stringByAppendingString:sname];
        //排除当前的touchBegin方法
        NSString *touchBegin = [NSString stringWithFormat:@"%s",__func__];
        BOOL isTouchBegin = [sname isEqualToString: touchBegin];
        if (![array containsObject:sname] && !isTouchBegin) {
            [array insertObject:sname atIndex:0];
        }
    }
    
    for (NSString *name in array) {
        NSLog(@"%@",name);
    }
    
    //写入order文件中
    NSString *funcContent = [array componentsJoinedByString:@"\n"];
    //写入文件
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingString:@"link.order"];
    NSLog(@"filePath = %@",filePath);
    NSData *fileData = [funcContent dataUsingEncoding:NSUTF8StringEncoding];
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileData attributes:NULL];
    
}


@end
