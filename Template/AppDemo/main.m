//
//  main.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import <UIKit/UIKit.h>
#import "JZAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([JZAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
