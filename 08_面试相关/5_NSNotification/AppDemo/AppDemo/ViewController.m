//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "Masonry.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    dispatch_queue_t queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//        NSLog(@"监听异步通知-线程：%@",[NSThread currentThread]);
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction) name:@"KTest" object:nil];
//    });
//    [self notificationQueueMain];
    [self test];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self postNotification];
}

- (void)postNotification {
    dispatch_queue_t queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"begin");
        NSLog(@"发送通知-线程：%@",[NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"KTest" object:nil];
        NSLog(@"end");
    });
}

- (void)notificationAction:(NSNotification *)not {
    sleep(2);
    NSLog(@"接收到通知-线程：%@ - %@",[NSThread currentThread],not.object);
}

- (void)notificationQueue {
//    typedef NS_ENUM(NSUInteger, NSPostingStyle) {
//        NSPostWhenIdle = 1, // 当runloop处于空闲状态时post
//        NSPostASAP = 2, // 当当前runloop完成之后立即post
//        NSPostNow = 3  // 立即post
//    };
    NSLog(@"发送通知");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"KKKKK" object:nil];
    
    
    dispatch_queue_t queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSNotification *notification = [NSNotification notificationWithName:@"KKKKK" object:nil];
        [[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostASAP];
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
}
- (void)notificationQueueMain {
//    typedef NS_ENUM(NSUInteger, NSPostingStyle) {
//        NSPostWhenIdle = 1, // 当runloop处于空闲状态时post
//        NSPostASAP = 2, // 当当前runloop完成之后立即post
//        NSPostNow = 3  // 立即post
//    };
    NSLog(@"发送通知");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"KKKKK" object:@"d"];
    NSNotification *notification = [NSNotification notificationWithName:@"KKKKK" object:@"d"];
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostASAP];
    NSLog(@"end");
}

- (void)test {
    // 接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"TestNotification" object:@"DD"];
    // 发送通知
    NSLog(@"发送通知");
    [NSNotificationCenter.defaultCenter postNotificationName:@"TestNotification" object:@"test"];
    //key(name) : value>key(object) : value(Observation)
}

- (void)handel:(NSArray*)images
         block:(void(^)(NSArray *result))block {
    
    NSOperationQueue *queue = [NSOperationQueue new];
    queue.maxConcurrentOperationCount = 2;
    NSUInteger size = images.count;
    dispatch_group_t group = dispatch_group_create();
    for (NSUInteger index = 0; index < size; index++) {
        UIImage *image = [images objectAtIndex:index];
        dispatch_group_enter(group);
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            dispatch_group_leave(group);
            ///process()
            
        }];
        [queue addOperation:op];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if(block){
            block(nil);
        }
    });
}

@end
