//
//  CTMediator+CT_DetailPage.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/14.
//

#import "CTMediator+CT_DetailPage.h"

//target
NSString * const kCTMediatorTargetDetailPage = @"DetailPage";
//方法：获取详情控制器
NSString * const kCTMediatorAction = @"nativeFetchDetailViewController";

@implementation CTMediator (CT_DetailPage)

- (UIViewController *)CTMediator_viewControllerForDetail {
    UIViewController *viewController = [self performTarget:kCTMediatorTargetDetailPage action:kCTMediatorAction params:@{
        @"firstName":@"caca",
        @"lastName":@"coco"
    } shouldCacheTarget:NO];
    return viewController;;
    
}

@end
