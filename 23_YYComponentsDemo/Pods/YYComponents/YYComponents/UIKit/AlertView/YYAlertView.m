//
//  YYAlertView.m
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/26.
//

#import "YYAlertView.h"

@implementation YYAlertViewConfig
- (instancetype)init {
    if (self = [super init]) {
        self.alertControllerStyle = UIAlertControllerStyleAlert;
    }
    return self;
}
@end

@interface YYAlertView()

@end

@implementation YYAlertView
/**
 显示弹框
 @param configBlock      配置
 @param actionTitles     按钮标题
 @param clickBlock       点击回调
 */
+ (void)showAlertViewWithConfig:(void(^)(YYAlertViewConfig *config))configBlock
                           actionTitles:(NSArray <NSString*> *)actionTitles
                                  click:(nullable void(^)(NSInteger index))clickBlock {
    YYAlertViewConfig *config = [YYAlertViewConfig new];
    if (configBlock) {
        configBlock(config);
    }
    NSArray *titles = actionTitles.copy;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:config.title message:config.message preferredStyle:config.alertControllerStyle];
    
    for (NSString *actionTitle in titles) {
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSInteger index = [titles indexOfObject:actionTitle];
            !clickBlock?:clickBlock(index);
        }];
        [alert addAction:action2];
    }
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [vc presentViewController:alert animated:NO completion:nil];
}
@end
