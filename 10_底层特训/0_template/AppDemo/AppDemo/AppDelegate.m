//
//  AppDelegate.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2022/5/23.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController= [ViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
