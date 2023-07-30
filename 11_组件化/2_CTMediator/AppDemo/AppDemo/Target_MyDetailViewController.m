//
//  Target_push.m
//  AppDemo
//
//  Created by Jentle on 2022/3/6.
//

#import "Target_push.h"
#import "MyDetailViewController.h"

@implementation Target_push

- (UIViewController *)Action_NativeToMyDetailViewController:(NSDictionary *)params {
    
    MyDetailViewController *detail = [[MyDetailViewController alloc] init];
    detail.par = params;
    return detail;
}

@end
