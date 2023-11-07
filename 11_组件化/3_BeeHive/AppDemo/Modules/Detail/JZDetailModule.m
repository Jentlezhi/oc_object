//
//  JZDetailModule.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/8/16.
// 每个Module单独处理App生命周期时间，原理也是为了解耦，职责分离。

#import "JZDetailModule.h"
#import "BeeHive.h"
#import "JZDetailViewController.h"

@interface JZDetailModule()<BHModuleProtocol>

@end

@implementation JZDetailModule

+ (void)load {
    //在load方法里注册module
//    [BeeHive registerDynamicModule:[self class]];
}

-(void)modInit:(BHContext *)context
{
    NSLog(@"模块初始化中");
    NSLog(@"%@",context.moduleConfigName);
}


- (void)modSetUp:(BHContext *)context
{
//    [[BeeHive shareInstance]  registerService:@protocol(JZDetailServiceProtocol) service:[JZDetailViewController class]];
    NSLog(@"TradeModule setup");

}

@end
