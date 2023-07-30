//
//  MainModuleApi.m
//  AppDemo
//
//  Created by Jentle on 2022/3/7.
//

#import "Target_MainModuleApi.h"

@implementation Target_MainModuleApi

+ (NSString *)greet:(NSDictionary *)par {
    NSString *content = [NSString stringWithFormat:@"欢迎%@%@",par[@"firstName"],par[@"secondName"]];
    return content;
}

@end
