//
//  YYAMapServices.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/12.
//

#import "YYAMapServices.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation YYAMapServices
static NSString *_aMapServicesApiKey;

+ (void)setApiKey:(NSString *)apiKey {
    _aMapServicesApiKey = apiKey;
    AMapServices *services = [AMapServices sharedServices];
    //开启 HTTPS 功能，您只需在配置高德 Key 前，添加开启 HTTPS 功能的代码
    [services setEnableHTTPS:YES];
    services.apiKey = apiKey;
}
+ (NSString *)apiKey {
    return _aMapServicesApiKey;
}

@end
