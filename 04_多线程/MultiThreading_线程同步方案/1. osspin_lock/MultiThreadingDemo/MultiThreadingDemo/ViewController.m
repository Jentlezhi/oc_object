//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"
#import <libkern/OSAtomic.h>

@interface ViewController ()

/// 存钱
@property(assign, nonatomic) int money;
/// 总票数
@property(assign, nonatomic) int ticketsCount;
/// ticketLock
@property(assign, nonatomic) OSSpinLock ticketLock;
/// moneyLock
@property(assign, nonatomic) OSSpinLock moneyLock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ticketsCount = 100;
    self.money = 5000;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self moneyOperation];
}

- (void)saleTickets {
    
    
    ///创建锁
    _ticketLock = OS_SPINLOCK_INIT;
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("gcd_group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        [self saleTicketsWithCount:10];
    });
    dispatch_group_async(group, queue, ^{
        [self saleTicketsWithCount:20];
    });
    dispatch_group_async(group, queue, ^{
        [self saleTicketsWithCount:15];
    });
}

- (void)saleTicketsWithCount:(NSInteger)count {
    
    for (NSInteger index = 0; index < count; index++) {
        [self saleTicket];
    }
}

- (void)saleTicket {
    ///加锁： 保证同一把锁
    OSSpinLockLock(&_ticketLock);
    int oldTicketCount = self.ticketsCount;
    sleep(1.5);
    oldTicketCount--;
    self.ticketsCount = oldTicketCount;
    NSLog(@"还剩%d张票 - %@",self.ticketsCount,[NSThread currentThread]);
    //解锁
    OSSpinLockUnlock(&_ticketLock);
}


- (void)moneyOperation {
    
    _moneyLock = OS_SPINLOCK_INIT;
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("gcd_group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        [self saveMoney];
    });
    dispatch_group_async(group, queue, ^{
        [self drawMoney];
    });
}


- (void)saveMoney {
    
    OSSpinLockLock(&_moneyLock);
    int oldMoney = self.money;
    sleep(1.5);
    oldMoney+=50;
    self.money = oldMoney;
    NSLog(@"存50，还剩%d元 - %@",oldMoney,[NSThread currentThread]);
    OSSpinLockUnlock(&_moneyLock);
}


- (void)drawMoney {
    
    OSSpinLockLock(&_moneyLock);
    int oldMoney = self.money;
    sleep(1.5);
    oldMoney-=20;
    self.money = oldMoney;
    NSLog(@"取20，还剩%d元 - %@",oldMoney,[NSThread currentThread]);
    OSSpinLockUnlock(&_moneyLock);
}

@end
