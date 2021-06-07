//
//  ViewController.m
//  MultiThreadingDemo
//
//  Created by Jentle on 2019/12/11.
//  Copyright © 2019 Jentle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/// 总票数
@property(assign, nonatomic) int ticketsCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ticketsCount = 100;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self saleTickets];

    
}

- (void)saleTickets {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("gcd_group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        [self saleTicketsWithCount:1];
    });
    dispatch_group_async(group, queue, ^{
        [self saleTicketsWithCount:10];
    });
    dispatch_group_async(group, queue, ^{
        [self saleTicketsWithCount:2];
    });
}

- (void)saleTicketsWithCount:(NSInteger)count {
    
    for (NSInteger index = 0; index < count; index++) {
        [self saleTicket];
    }
}

- (void)saleTicket {
    int oldTicketCount = self.ticketsCount;
    sleep(.2);
    oldTicketCount--;
    self.ticketsCount = oldTicketCount;
    NSLog(@"还剩%d张票 - %@",self.ticketsCount,[NSThread currentThread]);
}

@end
