//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(assign, nonatomic) NSInteger num;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self interView21];
}

- (void)interView00 {
    ///使用sync函数往当前串行队列中添加任务，会卡住当前的串行队列（产生死锁）
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"任务1");
        dispatch_async(queue, ^{
            NSLog(@"任务2");
        });
        NSLog(@"任务3");
    });
    NSLog(@"任务4");
}

- (void)interView01 {
    NSLog(@"---------------------------------------------");
    NSLog(@"任务1");
    dispatch_queue_t queue1 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue1, ^{
        NSLog(@"任务2");
    });
    dispatch_queue_t queue2 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue2, ^{
        NSLog(@"任务3");
    });
    dispatch_queue_t queue3 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue3, ^{
        NSLog(@"任务4");
    });
    dispatch_queue_t queue4 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue4, ^{
        NSLog(@"任务5");
    });
    dispatch_queue_t queue5 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue5, ^{
        NSLog(@"任务6");
    });
    NSLog(@"任务7");
}

- (void)interView0 {
    
    NSLog(@"任务1");
//    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"任务2");
    });
    dispatch_async(queue, ^{
        NSLog(@"任务4");
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务5");
    });
    NSLog(@"任务3");
    /*
     任务1
     任务3
     任务2
     */
    
//    NSLog(@"任务1");
//    dispatch_queue_t mainQueue = dispatch_get_main_queue();
//    dispatch_async(mainQueue, ^{
//        NSLog(@"任务2");
//    });
//    NSLog(@"任务4");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self interView1];
}

- (void)queue_create_serial_async {
//    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    for (int i = 0; i < 10; i++) {
        NSLog(@"任务3：index = %d %@",i,[NSThread currentThread]);
    }
//    NSLog(@"任务3 %@",[NSThread currentThread]);
    /*
     任务3 <NSThread: 0x600003444540>{number = 1, name = main}
     任务1：index = 0 <NSThread: 0x60000341c640>{number = 5, name = (null)}
     任务2：index = 0 <NSThread: 0x600003406900>{number = 4, name = (null)}
     任务1：index = 1 <NSThread: 0x60000341c640>{number = 5, name = (null)}
     任务2：index = 1 <NSThread: 0x600003406900>{number = 4, name = (null)}
     任务1：index = 2 <NSThread: 0x60000341c640>{number = 5, name = (null)}
     任务2：index = 2 <NSThread: 0x600003406900>{number = 4, name = (null)}
     任务2：index = 3 <NSThread: 0x600003406900>{number = 4, name = (null)}
     任务1：index = 3 <NSThread: 0x60000341c640>{number = 5, name = (null)}
     任务2：index = 4 <NSThread: 0x600003406900>{number = 4, name = (null)}
     任务1：index = 4 <NSThread: 0x60000341c640>{number = 5, name = (null)}
     任务2：index = 5 <NSThread: 0x600003406900>{number = 4, name = (null)}
     任务1：index = 5 <NSThread: 0x60000341c640>{number = 5, name = (null)}
     任务2：index = 6 <NSThread: 0x600003406900>{number = 4, name = (null)}
     任务1：index = 6 <NSThread: 0x60000341c640>{number = 5, name = (null)}
     任务2：index = 7 <NSThread: 0x600003406900>{number = 4, name = (null)}
     任务1：index = 7 <NSThread: 0x60000341c640>{number = 5, name = (null)}
     任务2：index = 8 <NSThread: 0x600003406900>{number = 4, name = (null)}
     任务1：index = 8 <NSThread: 0x60000341c640>{number = 5, name = (null)}
     任务2：index = 9 <NSThread: 0x600003406900>{number = 4, name = (null)}
     任务1：index = 9 <NSThread: 0x60000341c640>{number = 5, name = (null)}
     */
}

- (void)queue_create_serial_sync {
    
    ///DISPATCH_QUEUE_SERIAL or a NULL attribute invoke blocks serially in FIFO order
    ///DISPATCH_QUEUE_CONCURRENT attribute may invoke blocks concurrently
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务3：index = %d %@",i,[NSThread currentThread]);
        }
    });
    NSLog(@"--------------end --------------");
    
//    dispatch_sync(queue, ^{
//        for (int i = 0; i < 10; i++) {
//            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
//        }
//    });
    ///主线程中：任务1执行完之后执行任务2
}

- (void)queue_create_concurrent_async {
    
    ///DISPATCH_QUEUE_SERIAL or a NULL attribute invoke blocks serially in FIFO order
    ///DISPATCH_QUEUE_CONCURRENT attribute may invoke blocks concurrently
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    ///子线程中：任务1和任务2交替执行
}

- (void)queue_create_concurrent_sync {
    
    ///DISPATCH_QUEUE_SERIAL or a NULL attribute invoke blocks serially in FIFO order
    ///DISPATCH_QUEUE_CONCURRENT attribute may invoke blocks concurrently
    dispatch_queue_t queue = dispatch_queue_create("com.companyName.test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    ///主线程中：任务1执行完之后执行任务2，并发只在异步函数下才有效
}

- (void)gcd_main_queue_sync_crash {
    
    ///串行主队列:任务在主线程执行，主队列添加同步任务会死锁！！！
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    NSLog(@"任务3");
}

- (void)gcd_main_queue_async {
    
    ///串行主队列:任务在主线程执行，主队列添加同步任务会死锁！！！
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    ///主线程中：任务1执行完之后执行任务2
}

- (void)gcd_global_queue_async {
    ///全局并发队列:允许多个任务并发执行，并发在异步函数下才有效！！！
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    ///子线程中：任务1和任务2交替执行
}


- (void)gcd_global_queue_sync {
    ///全局并发队列:允许多个任务并发执行，并发在异步函数下才有效！！！
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务1：index = %d %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"任务2：index = %d %@",i,[NSThread currentThread]);
        }
    });
    ///主线程中：任务1执行完之后任务2再执行
    NSLog(@"任务3");
    ///执行顺序一定是：任务1、任务2、任务3
}

- (void)interView1 {
    //串行队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        sleep(10);
        NSLog(@"1-%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        sleep(1);
        NSLog(@"2-%@",[NSThread currentThread]);
    });
    
    sleep(2);
    
    dispatch_queue_t queue1 = dispatch_queue_create("test1", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue1, ^{
        NSLog(@"4-%@",[NSThread currentThread]);
    });
    
    dispatch_sync(queue1, ^{
        NSLog(@"5-%@",[NSThread currentThread]);
    });
    
    NSLog(@"3-%@",[NSThread currentThread]);
    /*
     2022-03-20 07:40:11.221797+0800 MultiThreadingDemo[20774:1460888] 1-<NSThread: 0x6000038f2b00>{number = 6, name = (null)}
     2022-03-20 07:40:12.223091+0800 MultiThreadingDemo[20774:1460717] 2-<NSThread: 0x60000389c7c0>{number = 1, name = main}
     2022-03-20 07:40:14.224606+0800 MultiThreadingDemo[20774:1460888] 4-<NSThread: 0x6000038f2b00>{number = 6, name = (null)}
     2022-03-20 07:40:14.225000+0800 MultiThreadingDemo[20774:1460717] 5-<NSThread: 0x60000389c7c0>{number = 1, name = main}
     2022-03-20 07:40:14.225318+0800 MultiThreadingDemo[20774:1460717] 3-<NSThread: 0x60000389c7c0>{number = 1, name = main}
     */
}

- (void)interView2 {
    
    
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t queue1 = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    NSLog(@"任务1");
    dispatch_sync(queue, ^{//block0
        NSLog(@"任务2");
        dispatch_async(queue, ^{//block1
            NSLog(@"任务3");
        });
        NSLog(@"任务4");
    });
    NSLog(@"任务5");
}


- (void)interView3 {
    
    NSLog(@"任务1");
    ///串行队列
    dispatch_queue_t queue1 = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue1, ^{//0
        NSLog(@"任务2");
        dispatch_sync(queue2, ^{//1
            NSLog(@"任务3");
        });
        NSLog(@"任务4");
    });
    NSLog(@"任务5");
}

- (void)interView4 {
    
    NSLog(@"任务1");
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    /*
     开启了异步线程，然后把任务添加到主队列里，立马就返回了，
     不会执行NSLog(@"任务2"),直到当前同步执行完再执行NSLog(@"任务2")
     */
    dispatch_async(mainQueue, ^{
        NSLog(@"任务2");
    });
    NSLog(@"任务3");
    for (int i = 0; i < 10000; i++) {
        NSLog(@"%d",i);
    }
    /*
     执行顺序：
     任务1
     任务3
     0
     ...
     9999
     任务2
     */
}

- (void)interView5 {
    
//    __block int b = 0;
//    NSLog(@"进来的时候 b = %d",b);
//    dispatch_sync(dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT), ^{
//        NSLog(@"%@===%d",[NSThread currentThread],b);
//        b++;
//    });
//    NSLog(@"出去的时候 b = %d",b);
//
//    return;
    
    __block int a = 0;
    while (a<5) {
        NSLog(@"进来的时候 a = %d",a);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"%@===%d",[NSThread currentThread],a);
            a++;
        });
        NSLog(@"出去的时候 a = %d",a);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"%@===%d",[NSThread currentThread],a);
//            a++;
//        });
    }
    NSLog(@"函数结束------------------%@-****%d",[NSThread currentThread],a);
}

- (void)interView6 {
    
    dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 100; i++) {
        dispatch_async(queue, ^{
//            NSLog(@"1");
            NSLog(@"1---------------%@-",[NSThread currentThread]);
        });
        dispatch_async(queue, ^{
//            NSLog(@"2");
            NSLog(@"2---------------%@-",[NSThread currentThread]);
        });
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
    }
//        NSLog(@"0");
//        dispatch_async(queue, ^{
//            NSLog(@"4");
//        });
//        dispatch_async(queue, ^{
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                NSLog(@"5");
//            });
//        });
//        dispatch_async(queue, ^{
//            NSLog(@"6");
//        });
}

- (void)interView7 {
    
    for (int i = 0; i < 10; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.num++;
        });
    }
    NSLog(@"%ld", (long)self.num);
//    self.num = 0;
}

- (void)interView8 {
    
    NSLog(@"1");
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_async(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    
    //1 5 2 4 3
}

- (void)interView9 {
    // 主队列:专门负责调度主线程度的任务，没有办法开辟新的线程
    dispatch_queue_main_t queue = dispatch_get_main_queue();
    // 主队列执行异步，并不会开启新的线程
    /*
     现将任务放在主队列中，但是不是马上执行，
     等到主队列中的其它所有除我们使用代码添加
     到主队列的任务的任务都执行完毕之后才会执行
     我们使用代码添加的任务
     */
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);//<NSThread: 0x6000014ac640>{number = 1, name = main}
    });
    
    /*
     因此代码任务就必须等待，而主线程又在等待代码
     任务的完成好去完成下面的任务，因此就形成了相
     互等待。整个主线程就被阻塞了，死锁了。
     */
//    dispatch_sync(queue, ^{
//        NSLog(@"%@",[NSThread currentThread]);//<NSThread: 0x6000014ac640>{number = 1, name = main}
//    });//Thread 1: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0
    NSLog(@"%s",__func__);
}

- (void)interView10 {
    
    dispatch_queue_t queue1 = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue2 = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
//    for (int i = 0; i < 100; i++) {
//        dispatch_async(queue1, ^{
//            NSLog(@"%d - %@",i,[NSThread currentThread]);
//        });
//    }
    
    dispatch_async(queue1, ^{
        NSLog(@"任务A - %@",[NSThread currentThread]);
    });
    
//    dispatch_sync(queue1, ^{
//        NSLog(@"任务B - %@",[NSThread currentThread]);
//    });
//
//    dispatch_async(queue1, ^{
//        NSLog(@"任务C - %@",[NSThread currentThread]);
//    });
//
//    dispatch_async(queue1, ^{
//        NSLog(@"任务D - %@",[NSThread currentThread]);
//    });
//
//    dispatch_async(queue1, ^{
//        NSLog(@"任务E - %@",[NSThread currentThread]);
//    });
    
}

- (void)interView11 {
    
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        NSLog(@"1");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_async(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    dispatch_async(queue, ^{
        NSLog(@"5");
    });
    // A.15243 B.15234 C.12543 D.12453
    // 答案:A和C
}

- (void)interView12 {
//    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
//    NSLog(@"1");
//    dispatch_async(queue, ^{
//        NSLog(@"2");
//        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//            NSLog(@"3");
//        });
//        NSLog(@"4");
//    });
//    NSLog(@"5");
    
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(queue, ^{
//        sleep(5);
        NSLog(@"2");
    });
//    dispatch_sync(queue, ^{
////        sleep(3);
//        NSLog(@"3");
//    });
//    sleep(1);
    NSLog(@"4");
    
}

- (void)interView13 {
//    for (int i = 0; i < 100; i++) {
////        dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
//        dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
////        dispatch_queue_t queue = dispatch_get_main_queue();
//        NSLog(@"任务1");
//        dispatch_async(queue, ^{//block0
//            NSLog(@"任务2----------------------------------");
//    //        dispatch_sync(queue, ^{//block1
//    //            NSLog(@"任务3");
//    //        });
//    //        NSLog(@"任务4");
//        });
//        NSLog(@"任务5");
//    }
    //DISPATCH_QUEUE_CONCURRENT:15234
    //DISPATCH_QUEUE_SERIAL:15234
    
    for (int i = 0; i < 1; i++) {
//        dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
        dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
        dispatch_async(queue, ^{
            sleep(3);
            NSLog(@"任务1");
//            dispatch_async(queue, ^{
//                NSLog(@"任务2");
//            });
        });
        dispatch_sync(queue, ^{
            NSLog(@"任务2");
        });
        NSLog(@"任务3");
//        dispatch_queue_t queue = dispatch_get_main_queue();
//        NSLog(@"任务1");
//        dispatch_async(queue, ^{//block0
//            NSLog(@"任务2----------------------------------");
//    //        dispatch_sync(queue, ^{//block1
//    //            NSLog(@"任务3");
//    //        });
//    //        NSLog(@"任务4");
//        });
//        NSLog(@"任务5");
    }
}

- (void)interView14 {
    
    //并发队列
    dispatch_queue_t q = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t q = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    //异步任务
    dispatch_async(q, ^{
        //同步并发
        NSLog(@"EEEE %@", [NSThread currentThread]);
//        dispatch_sync(q, ^{
//            NSLog(@"AAAA %@", [NSThread currentThread]);
//        });
//        //异步并发
//        dispatch_async(q, ^{
//            NSLog(@"BBBB %@", [NSThread currentThread]);
//        });
//        //异步并发
//        dispatch_async(q, ^{
//            NSLog(@"CCCC %@", [NSThread currentThread]);
//        });

//        for (int i = 0; i < 10; i++) {
//            NSLog(@"%d   %@", i, [NSThread currentThread]);
//        }
    });
    NSLog(@"DDDD %@", [NSThread currentThread]);
    /*
     如果queue是DISPATCH_QUEUE_SERIAL,结果为：EEEE 崩溃
     如果queue是DISPATCH_QUEUE_CONCURRENT,结果为：DDDD 崩溃
     */
}

- (void)interView15 {
    
    //并发队列
    dispatch_queue_t q = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    //同步并发
    dispatch_sync(q, ^{
        NSLog(@"AAAA %@", [NSThread currentThread]);
    });
    //异步并发
    dispatch_async(q, ^{
        NSLog(@"BBBB %@", [NSThread currentThread]);
    });
    //异步并发
    dispatch_async(q, ^{
        NSLog(@"CCCC %@", [NSThread currentThread]);
    });

    for (int i = 0; i < 10; i++) {
        NSLog(@"%d   %@", i, [NSThread currentThread]);
    }
}

- (void)interView16 {
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    dispatch_async(queue, ^{
        NSLog(@"6");
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"7");
        });
        NSLog(@"8");
    });
    NSLog(@"5");
    
    //15 26 43 78
    //15 62 43 78
}

- (void)interView17 {
    //新浪微博
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1");
    });
    dispatch_async(queue, ^{
        NSLog(@"2");
    });
    dispatch_sync(queue, ^{
        NSLog(@"3");
    });
    NSLog(@"0");
    dispatch_async(queue, ^{
        NSLog(@"7");
    });
    dispatch_async(queue, ^{
        NSLog(@"8");
    });
    dispatch_async(queue, ^{
        NSLog(@"9");
    });
    /*
     A:1230789 ✅
     B:1237890
     C:3120789 ✅
     D:2137890
     */
}

- (void)interView18 {

    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");//任务1
    dispatch_async(queue, ^{
        NSLog(@"2");//任务2
    });
    NSLog(@"3");//任务3
    dispatch_sync(queue, ^{
        NSLog(@"4");//任务4
    });
    NSLog(@"5");//任务5
    /*
     13245
     分析：
     1.首先执行任务1，打印1
     2.任务2添加到队列中，立即返回
     3.执行任务3，打印3
     4.任务4添加到队列中，并且是同步，所以先执行任务4，
       这时串行队列中（FIFO）有任务2,所以要想执行任务4，
       必须先执行任务2，打印2，然后再执行任务4，打印4
     5.执行任务5，打印5
     
     */
    
}

/**
 * 异步执行 + 串行队列
 * 特点：会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
 */
- (void)interView19 {
    
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"asyncSerial---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_SERIAL);
    
//    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        // 追加任务 1
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    
    dispatch_async(queue, ^{
        // 追加任务 2
        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    
    dispatch_async(queue, ^{
        // 追加任务 3
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    dispatch_sync(queue, ^{
        // 追加任务 4
//        [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
        NSLog(@"4---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
    NSLog(@"asyncSerial---end");
}
- (void)interView20 {
    NSLog(@"begin");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"async task");
    });
    NSLog(@"end");//执行顺序：begin、end、async task
}
- (void)interView21 {
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        dispatch_sync(queue, ^{
            NSLog(@"sync task");
        });
    });
    
}
@end
