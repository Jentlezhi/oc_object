//
//  JZEmptyDataSet.h
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/11/16.
//  Copyright © 2023 Github. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIScrollView+EmptyDataSet.h"

@class JZEmptyDataSet;

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (JZEmptyDataSet)

@property(nonatomic, strong) id<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate> emptyDataSet;

@end

///配置文件
@interface JZEmptyDataSetConfig : NSObject



+ (instancetype)defaultConfig;


@end
@interface JZEmptyDataSet : NSObject<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

+ (instancetype)dataSetWithDataSource:(nonnull id)dataSource
                      customEmptyView:(UIView * _Nullable  (^)(void))customEmptyViewBlock
                            errorView:(UIView * _Nullable (^)(void))errorViewBlock
                               config:(void (^)(JZEmptyDataSetConfig *config))configBlock;

@end

NS_ASSUME_NONNULL_END
