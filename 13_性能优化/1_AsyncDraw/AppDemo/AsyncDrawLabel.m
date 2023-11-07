//
//  AsyncDrawLabel.m
//  AppDemo
//
//  Created by Jentle on 2022/3/28.
//

#import "AsyncDrawLabel.h"
#import <CoreText/CoreText.h>

@implementation AsyncDrawLabel

- (void)displayLayer:(CALayer *)layer {
    
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    // 异步绘制，切换至子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
        // 获取当前上下文
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self draw:context size:size];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 子线程完成工作，切换至主线程显示
        dispatch_async(dispatch_get_main_queue(), ^{
            self.layer.contents = (__bridge id)image.CGImage;
        });
    });
}

- (void)draw:(CGContextRef)context size:(CGSize)size {
    // 将坐标系上下翻转，因为底层坐标系和 UIKit 坐标系原点位置不同。
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    // 文本沿着Y轴移动
    CGContextTranslateCTM(context, 0, size.height); // 原点为左下角
    // 文本反转成context坐标系
    CGContextScaleCTM(context, 1, -1);
    // 创建绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
    // 创建需要绘制的文字
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attrStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, self.text.length)];
    // 根据attStr生成CTFramesetterRef
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrStr);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrStr.length), path, NULL);
    // 将frame的内容绘制到content中
    CTFrameDraw(frame, context);
}

@end
