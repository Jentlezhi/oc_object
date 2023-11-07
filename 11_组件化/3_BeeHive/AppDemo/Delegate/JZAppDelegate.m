//
//  JZAppDelegate.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/15.
//

#import "JZAppDelegate.h"
#import "JZMainViewController.h"
#import "BHContext.h"
#import "BHTimeProfiler.h"

@implementation JZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [BHContext shareInstance].application = application;
    [BHContext shareInstance].launchOptions = launchOptions;
    [BHContext shareInstance].moduleConfigName = @"BeeHive.bundle/BeeHive";//可选，默认为BeeHive.bundle/BeeHive.plist
    [BHContext shareInstance].serviceConfigName = @"BeeHive.bundle/BHService";
    
    [BeeHive shareInstance].enableException = YES;
    [[BeeHive shareInstance] setContext:[BHContext shareInstance]];
    [[BHTimeProfiler sharedTimeProfiler] recordEventTime:@"BeeHive::super start launch"];
    
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:JZMainViewController.new];
    [self.window makeKeyAndVisible];
    #if DEBUG
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    #endif
    return YES;
}

@end
