//
//  JZDetailServiceProtocol.h
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/16.
//
#import <Foundation/Foundation.h>
#import "BHServiceProtocol.h"

@protocol JZDetailServiceProtocol <NSObject,BHServiceProtocol>

@property(nonatomic, copy) NSString *info;
@property(nonatomic, copy) void(^callback)(NSString *text);

///传值&回调
- (UIViewController *)featchDetailVCWithInfo:(NSString *)info
                               valueCallback:(void(^)(NSString *value))callBack;

@end
