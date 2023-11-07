//
//  MyView.m
//  AspectsDemo
//
//  Created by Jentle on 2021/10/9.
//

#import "MyView.h"

@interface MyView ()

@property(strong, nonatomic) UIView *view;

@end

@implementation MyView

- (instancetype)init {
    
    if (self = [super init]) {
        self.view = [UIView new];
        self.view.backgroundColor = UIColor.orangeColor;
        self.view.frame = CGRectMake(0, 0, 50, 50);
        [self addSubview:self.view];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self.view addGestureRecognizer:tap];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.view.center = self.center;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {

    NSLog(@"%s",__func__);
    NSLog(@"%@",NSStringFromCGPoint(point));
    return CGRectContainsPoint(CGRectMake(0, 0, 100, 100), point);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    NSLog(@"%s",__func__);
    [self setNeedsDisplay];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    return [super hitTest:point withEvent:event];
}

- (void)tapAction {
    
    NSLog(@"%s",__func__);
}

@end
