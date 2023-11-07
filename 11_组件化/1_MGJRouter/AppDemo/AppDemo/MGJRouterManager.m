//
//  MGJRouterManager.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/14.
//

#import "MGJRouterManager.h"
#import "MyDetailViewController.h"
#import "MGJRouter.h"

@implementation MGJRouterManager

+ (void)load {
    ///注册详情页
    [MGJRouter registerURLPattern:@"MGJ://detail" toHandler:^(NSDictionary *routerParameters) {
        NSDictionary *info = routerParameters[MGJRouterParameterUserInfo];
        UIViewController *vc = (UIViewController*)[info valueForKey:@"vc"];
        MyDetailViewController *detailVC = [MyDetailViewController new];
        detailVC.backBlock = info[@"block"];
        detailVC.label.text = info[@"firstName"];
        [vc presentViewController:detailVC animated:YES completion:nil];
        NSLog(@"%@",routerParameters);
    }];
}

@end
