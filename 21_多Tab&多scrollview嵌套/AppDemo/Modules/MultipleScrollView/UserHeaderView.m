//
//  UserHeaderView.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/11/14.
//

#import "UserHeaderView.h"

@interface UserHeaderView()

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, assign) CGRect imageViewFrame;

@end

@implementation UserHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self reSetFrame:frame];
    }
    return self;
}
- (UIImageView *)imageView {
    if (!_imageView){
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"lufei.jpg"];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageViewFrame = self.bounds;
}

- (void)reSetFrame:(CGRect)frame {
    self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY {
    CGRect frame = self.imageViewFrame;
    frame.size.height -= contentOffsetY;
    frame.origin.y = contentOffsetY;
    self.imageView.frame = frame;
}

@end
