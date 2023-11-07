//
//  CustomView.m
//  AppDemo
//
//  Created by Jentle-Zhi on 2023/9/14.
//

#import "CustomView.h"

@implementation CustomView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    //调用pointInside：withEvent：判断点在不在view身上
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    return [super pointInside:point withEvent:event];
}

@end
