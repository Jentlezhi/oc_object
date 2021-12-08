//
//  YYFPSLabel.m
//  YYKitExample
//
//  Created by ibireme on 15/9/3.
//  Copyright (c) 2015 ibireme. All rights reserved.
//

#import "YYFPSLabel.h"
#import "YYKit.h"

#define kSize CGSizeMake(55, 20)

@implementation YYFPSLabel {
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
    UIFont *_subFont;
    
    NSTimeInterval _llll;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size = kSize;
    }
    self = [super initWithFrame:frame];
    
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    
    _font = [UIFont fontWithName:@"Menlo" size:14];
    if (_font) {
        _subFont = [UIFont fontWithName:@"Menlo" size:4];
    } else {
        _font = [UIFont fontWithName:@"Courier" size:14];
        _subFont = [UIFont fontWithName:@"Courier" size:4];
    }
    
    _link = [CADisplayLink displayLinkWithTarget:[YYWeakProxy proxyWithTarget:self] selector:@selector(tick:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return self;
}

- (void)dealloc {
    [_link invalidate];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return kSize;
}

// 60 vs 16.67ms
// 1/60  * 1000 
- (void)tick:(CADisplayLink *)link {
    //首次调用tick函数时候的调用，记录起始时间
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    //记录tick函数调用次数，大致上每秒调用60次
    _count++;
    NSLog(@"_count = %lu",(unsigned long)_count);
    //timestamp属性: 只读的CFTimeInterval值，表示屏幕显示的上一帧的时间戳
    //记录tick函数调用与起始时间的差值，如果小于一秒继续return，继续计数tick调用次数。
    NSTimeInterval delta = link.timestamp - _lastTime;
//    NSLog(@"timestamp = %f",link.timestamp);
//    NSLog(@"delta = %f",delta);
    if (delta < 1) return;
    _lastTime = link.timestamp;
    //大致上每一秒调用一次
    NSLog(@"-----------------------------------------------");
    float fps = _count / delta;
    //帧率：每秒显示帧数，计算方法为：单位时间内刷新的次数
    
    //重置计数变量
    _count = 0;
    
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text setColor:color range:NSMakeRange(0, text.length - 3)];
    [text setColor:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
    text.font = _font;
    [text setFont:_subFont range:NSMakeRange(text.length - 4, 1)];
    
    self.attributedText = text;
}

@end
