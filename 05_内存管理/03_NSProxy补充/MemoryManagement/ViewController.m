//
//  ViewController.m
//  MemoryManagement
//
//  Created by Jentle on 2019/12/19.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "NSTimerDelegate.h"
#import "JTProxy.h"
#import "JTObjectProxy.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///神奇的NSProxy:isMemberOfClass、isKindOfClass等内部的实现进行了消息转发
    JTProxy *proxy = [JTProxy proxyWithTarget:self];
    bool ret1 = [proxy isMemberOfClass:[self class]];
    JTObjectProxy *objProxy = [JTObjectProxy proxyWithTarget:self];
    bool ret2 = [objProxy isMemberOfClass:[self class]];
    NSLog(@"ret1=%d",ret1);//1
    NSLog(@"ret2=%d",ret2);//0
}

@end
