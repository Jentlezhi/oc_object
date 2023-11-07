//
//  Target_DetailPage.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/14.
//

#import "Target_DetailPage.h"
#import "MyDetailViewController.h"

@implementation Target_DetailPage

- (UIViewController *)Action_nativeFetchDetailViewController:(NSDictionary *)par {
    MyDetailViewController *detail = [MyDetailViewController new];
    detail.par = par.copy;
    return detail;
}

@end
