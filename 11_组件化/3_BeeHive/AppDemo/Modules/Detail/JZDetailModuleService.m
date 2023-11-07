//
//  JZDetailModuleService.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/16.
//

#import "JZDetailModuleService.h"
#import "JZDetailViewController.h"

@implementation JZDetailModuleService

- (UIViewController *)nativeFetchDetailViewController:(NSDictionary *)params {
    
    JZDetailViewController *detailVC = [JZDetailViewController new];
    detailVC.info = [params valueForKey:@"info"];
    return detailVC;
}

@end
