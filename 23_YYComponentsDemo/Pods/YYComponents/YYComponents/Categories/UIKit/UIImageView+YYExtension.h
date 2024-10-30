//
//  UIImageView+YYExtension.h
//  YYComponents
//
//  Created by Jentle-Zhi on 2018/06/08.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYImageViewConfig : NSObject

@property(nonatomic, strong) UIImage *image;

@property(nonatomic, copy) NSString *imageName;

@property(nonatomic, strong) UIColor *backgroundColor;

@property(nonatomic, assign) UIViewContentMode contentMode;

@property(nonatomic, assign) CGFloat cornerRaduis;

@property(nonatomic, assign) CGFloat borderWidth;

@property(nonatomic, strong) UIColor *borderColor;

@property(nonatomic, assign) BOOL hidden;

@end

@interface UIImageView (YYExtension)

+ (instancetype)yy_imageViewWithConfig:(void(^)(YYImageViewConfig *config))configBlock;

/**
 生成一个和该对象特征一样的对象，仅限YYImageViewConfig中的属性
 @return            新对象
 */
- (instancetype)yy_copy;
/**
 生成一个和该对象特征一样的对象，仅限YYImageViewConfig中的属性
 @param configBlock      配置block
 @return                 新对象
 */
- (instancetype)yy_copyWithConfig:(nullable void(^)(YYImageViewConfig *config))configBlock;

@end

NS_ASSUME_NONNULL_END
