//
//  JZAppDelegate.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/15.
//

#import "JZAppDelegate.h"
#import "JZMainViewController.h"
#import "JZBaseNavigationController.h"

@implementation JZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[JZBaseNavigationController alloc] initWithRootViewController:JZMainViewController.new];
    [self.window makeKeyAndVisible];
    #if DEBUG
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    #endif
    return YES;
}

@end
