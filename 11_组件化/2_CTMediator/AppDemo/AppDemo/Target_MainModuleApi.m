//
//  MainModuleApi.m
//  AppDemo
//
//  Created by Jentle on 2022/3/7.
//

#import "Target_MainModuleApi.h"

@implementation Target_MainModuleApi

- (NSString *)Action_greet:(NSDictionary *)par {
    NSString *content = [NSString stringWithFormat:@"欢迎%@%@",par[@"firstName"],par[@"secondName"]];
    return content;
}

- (UIImageView *)Action_getImageView:(NSDictionary *)par {
    UIImageView *igv = [UIImageView new];
    igv.image = [par valueForKey:@"image"];
    return igv;
}

@end
