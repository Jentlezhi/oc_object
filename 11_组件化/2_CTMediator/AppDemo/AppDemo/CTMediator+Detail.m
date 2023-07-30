//
//  CTMediator+Home.m
//  AppDemo
//
//  Created by Jentle on 2022/3/6.
//

#import "CTMediator+Home.h"

@implementation CTMediator (Detail)

- (UIViewController *)CTMediator_DetailController:(NSDictionary *)param {
    return [self performTarget:@"HomeController" action:@"CreateHomeController" params:nil shouldCacheTarget:NO];
}

@end
