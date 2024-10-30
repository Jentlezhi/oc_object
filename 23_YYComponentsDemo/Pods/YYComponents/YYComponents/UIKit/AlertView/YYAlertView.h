//
//  YYAlertView.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2021/1/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYAlertViewConfig : NSObject
///标题
@property(nonatomic, copy) NSString *title;
///内容
@property(nonatomic, copy) NSString *message;
///类型
@property(nonatomic, assign) UIAlertControllerStyle alertControllerStyle;

@end

@interface YYAlertView : NSObject

/**
 显示弹框
 @param configBlock      配置
 @param actionTitles     按钮标题
 @param clickBlock       点击回调
 */
+ (void)showAlertViewWithConfig:(void(^)(YYAlertViewConfig *config))configBlock
                           actionTitles:(NSArray <NSString*> *)actionTitles
                          click:(nullable void(^)(NSInteger index))clickBlock;

@end

NS_ASSUME_NONNULL_END
