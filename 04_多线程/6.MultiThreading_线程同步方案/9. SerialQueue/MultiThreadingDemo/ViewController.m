//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//  串行队列保证线程同步

#import "ViewController.h"

@interface ViewController ()

/// 存钱
@property(assign, nonatomic) int money;
/// 总票数
@property(assign, nonatomic) int ticketsCount;
/// ticketQueue
@property(strong, nonatomic) dispatch_queue_t ticketQueue;
/// moneyQueue
@property(strong, nonatomic) dispatch_queue_t moneyQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ticketsCount = 100;
    self.money = 5000;
    self.ticketQueue = dispatch_queue_create("ticketQueue", DISPATCH_QUEUE_SERIAL);
    self.moneyQueue = dispatch_queue_create("moneyQueue", DISPATCH_QUEUE_SERIAL);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self saleTickets];
}

- (void)saleTickets {
    
    
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
    
    dispatch_async(self.ticketQueue, ^{
        int oldTicketCount = self.ticketsCount;
        sleep(1.5);
        oldTicketCount--;
        self.ticketsCount = oldTicketCount;
        NSLog(@"还剩%d张票 - %@",self.ticketsCount,[NSThread currentThread]);
    });
}


- (void)moneyOperation {
    

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
    
    dispatch_async(self.moneyQueue, ^{
        int oldMoney = self.money;
        sleep(1.5);
        oldMoney+=50;
        self.money = oldMoney;
        NSLog(@"存50，还剩%d元 - %@",oldMoney,[NSThread currentThread]);
    });

}


- (void)drawMoney {
    
    dispatch_async(self.moneyQueue, ^{
        int oldMoney = self.money;
        sleep(1.5);
        oldMoney-=20;
        self.money = oldMoney;
        NSLog(@"取20，还剩%d元 - %@",oldMoney,[NSThread currentThread]);
    });
}

@end
