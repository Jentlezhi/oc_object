//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self interview21];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)interview01{
    ///问题：以下代码是在主线程执行，会不会产生死锁？
    ///会产生死锁
    NSLog(@"任务1");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"任务2");
    });
    NSLog(@"任务3");
}

- (void)interview02{
    ///问题：以下代码是在主线程执行，会不会产生死锁？
    ///不会产生死锁: 执行顺序为：任务1 任务3 任务2
    NSLog(@"任务1");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"任务2");
    });
//    dispatch_async(queue, ^{
//        NSLog(@"任务4");
//    });
    NSLog(@"任务3");
}

- (void)interview03{
    ///问题：以下代码是在主线程执行，会不会产生死锁？
    ///会产生死锁
    NSLog(@"任务1");
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{///block0
        NSLog(@"任务2");
        dispatch_sync(queue, ^{///block1
            NSLog(@"任务3");
        });
//        dispatch_async(queue, ^{///block1
//            NSLog(@"任务3");
//        });
        NSLog(@"任务4");
    });
    NSLog(@"任务5");
    ///任务1 -> 任务5 -> 任务2 -> 崩溃
}

- (void)interview04{
    ///问题：以下代码是在主线程执行，会不会产生死锁？
    ///不会产生死锁
    NSLog(@"任务1");
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue0 = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{///block0
        NSLog(@"任务2");
        dispatch_sync(queue0, ^{///block1
            NSLog(@"任务3");
        });
        NSLog(@"任务4");
    });
    NSLog(@"任务5");
    ///任务1 -> 任务5 -> 任务2 -> 任务3 -> 任务4
}

- (void)interview05{
    ///问题：以下代码是在主线程执行，会不会产生死锁？
    ///不会产生死锁
    NSLog(@"任务1");
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{///block0
        NSLog(@"任务2");
        dispatch_sync(queue, ^{///block1
            NSLog(@"任务3");
        });
        NSLog(@"任务4");
    });
    NSLog(@"任务5");
    ///任务1 -> 任务5 -> 任务2 -> 任务3 -> 任务4
}

- (void)interview06{
    
    //    NSLog(@"------------主线程-----------------");
    //    NSLog(@"1");
    //    ///afterDelay：底层是定时器，添加到runLoop中，runLoop休眠前处理任务。
    //    [self performSelector:@selector(printNumber2) withObject:nil afterDelay:.0];/// 输出 1 3 2
    //    NSLog(@"3");
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"1");
//        [self performSelector:@selector(printNumber2) withObject:nil];/// 输出 1 2 3
        ///这句代码的本质是往RunLoop中添加定时器，子线程默认没有开启RunLoop
//        [self performSelector:@selector(printNumber2) withObject:nil afterDelay:.0];/// 输出 1 3
//        [self performSelector:@selector(printNumber2) onThread:[NSThread currentThread] withObject:nil waitUntilDone:YES];//waitUntilDone:控制是否等待下面的执行
        NSLog(@"3");
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init]forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)printNumber2 {
    
    NSLog(@"2");
}

- (void)interview07 {
    ///
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1");
        //RunLoop
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop] run];
    }];
    [thread start];
    ///崩溃：[ViewController performSelector:onThread:withObject:waitUntilDone:modes:]: target thread exited while waiting for the perform'
    [self performSelector:@selector(printNumber2) onThread:thread withObject:nil waitUntilDone:YES];
    
    //为了避免崩溃，可以runloop保住线程的命，不让其销毁。[[NSRunLoop currentRunLoop] run];本质上就是开启了一个while循环，让runLoop一直运行
}

- (void)interview08 {
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    NSLog(@"任务1");
//    dispatch_sync(queue, ^{//a
//        NSLog(@"任务2");
//        dispatch_sync(queue, ^{//b
//            NSLog(@"任务3");
//        });
//        NSLog(@"任务4");
//    });
    dispatch_async(queue, ^{//a
        NSLog(@"任务2");
        dispatch_sync(queue, ^{//b
            NSLog(@"任务3");
        });
        NSLog(@"任务4");
    });
    NSLog(@"任务5");
}

- (void)interview09 {
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{//a
        NSLog(@"任务2");
        dispatch_sync(queue, ^{//b
            NSLog(@"任务3");
        });
        NSLog(@"任务4");
    });
    NSLog(@"任务5");
}

- (void)interview10 {
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"任务1");
    dispatch_sync(queue, ^{//a
        NSLog(@"任务2");
        dispatch_sync(queue, ^{//b
            NSLog(@"任务3");
        });
        NSLog(@"任务4");
    });
    NSLog(@"任务5");
}
- (void)interview11 {
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"任务1");
    dispatch_sync(queue, ^{//a
        NSLog(@"任务2");
        dispatch_sync(queue, ^{//b
            NSLog(@"任务3");
        });
        NSLog(@"任务4");
    });
    NSLog(@"任务5");
}

- (void)interview12 {
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(queue, ^{    // 异步执行 + 串行队列
//        NSLog(@"3");
        dispatch_sync(queue, ^{  // 同步执行 + 当前串行队列
            // 追加任务 1
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
    NSLog(@"2");
}

- (void)interview13 {
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_async(queue, ^{    // 异步执行 + 串行队列
        NSLog(@"3");
        dispatch_sync(queue, ^{  // 同步执行 + 当前串行队列
            // 追加任务 1
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        });
    });
    NSLog(@"2");
}
- (void)interview14 {
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{    // 异步执行 + 并行队列
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
}
- (void)interview15 {
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"start");
    for (int index = 0; index < 20; index++) {
        dispatch_sync(queue, ^{
            NSLog(@"任务%d - %@",index,[NSThread currentThread]);
        });
    }
    NSLog(@"end");
}
- (void)interview16 {
    __block int a = 0;
    while (a<5) {
        NSLog(@"进来的时候 a = %d",a);
        //        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        ////            NSLog(@"%@===%d",[NSThread currentThread],a);
        //            a++;
        //        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@===%d",[NSThread currentThread],a);
            a++;
        });
    }
    NSLog(@"%@****%d",[NSThread currentThread],a);
}
- (void)interview17 {
    dispatch_queue_t queue = dispatch_queue_create("serial", nil);
    dispatch_async(queue, ^(void){
        NSLog(@"1");
    });
    dispatch_sync(queue, ^(void){
        NSLog(@"2");
    });
    dispatch_async(queue, ^(void){
        NSLog(@"3");
//        dispatch_async(queue, ^(void){
//            NSLog(@"4");
//        });
        dispatch_sync(queue, ^(void){
            NSLog(@"4");
        });
    });
    NSLog(@"5");
}

- (void)interview18 {
    NSLog(@"任务1");
    dispatch_queue_t queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"任务2- %@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3- %@",[NSThread currentThread]);
    });
    NSLog(@"任务4");//这里仅限简单任务，复杂任务在主队列中也会先执行任务3，其他队列下不一定；
}

- (void)interview19 {
    NSOperationQueue *queue= [[NSOperationQueue alloc] init];
    //创建操作
    NSBlockOperation *operation1=[NSBlockOperation blockOperationWithBlock:^(){
        NSLog(@"执行第1次操作，线程：%@",[NSThread currentThread]);
    }];
    NSBlockOperation *operation2=[NSBlockOperation blockOperationWithBlock:^(){
        NSLog(@"执行第2次操作，线程：%@",[NSThread currentThread]);
    }];
    NSBlockOperation *operation3=[NSBlockOperation blockOperationWithBlock:^(){
        NSLog(@"执行第3次操作，线程：%@",[NSThread currentThread]);
    }];
    //添加依赖
    [operation1 addDependency:operation2];
    [operation2 addDependency:operation3];
    //将操作添加到队列中去
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
}

- (void)interview20 {
    NSLog(@"start");
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"%d",i);
        }
    }];
    [thread start];
    NSLog(@"end");
    /*
     2023-10-18 15:03:56.023093+0800 MultiThreadingDemo[51070:1474026] start
     2023-10-18 15:03:56.023244+0800 MultiThreadingDemo[51070:1474026] end
     2023-10-18 15:03:56.023337+0800 MultiThreadingDemo[51070:1474241] 0
     2023-10-18 15:03:56.023452+0800 MultiThreadingDemo[51070:1474241] 1
     2023-10-18 15:03:56.023585+0800 MultiThreadingDemo[51070:1474241] 2
     2023-10-18 15:03:56.023691+0800 MultiThreadingDemo[51070:1474241] 3
     2023-10-18 15:03:56.023793+0800 MultiThreadingDemo[51070:1474241] 4
     2023-10-18 15:03:56.023912+0800 MultiThreadingDemo[51070:1474241] 5
     2023-10-18 15:03:56.024021+0800 MultiThreadingDemo[51070:1474241] 6
     2023-10-18 15:03:56.024175+0800 MultiThreadingDemo[51070:1474241] 7
     2023-10-18 15:03:56.024288+0800 MultiThreadingDemo[51070:1474241] 8
     2023-10-18 15:03:56.024392+0800 MultiThreadingDemo[51070:1474241] 9
     */
}

- (void)interview21 {
    NSLog(@"1");
//    dispatch_queue_t queue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < 20; i++) {
        dispatch_async(queue, ^{
            NSLog(@"编号-%d - %@",i,[NSThread currentThread]);
        });
    }
    NSLog(@"2");
}

- (void)interview22 {
    dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");////任务1
    dispatch_async(queue, ^{//任务2
        NSLog(@"2");
    });
    dispatch_async(queue, ^{//任务3
        NSLog(@"3");
    });
    NSLog(@"4");//任务4
    dispatch_sync(queue, ^{//任务5
        NSLog(@"5");
    });
    NSLog(@"6");////任务6
    ///
    ///1 4 2 3 5 6
}

@end
