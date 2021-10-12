//
//  ViewController.m
//  YYFPSLabelDemo
//
//  Created by Jentle on 2021/10/12.
//

#import "ViewController.h"
#import "YYFPSLabel.h"

@interface ViewController ()

@property(strong, nonatomic) YYFPSLabel *fpsLabel;

@end

@implementation ViewController

- (YYFPSLabel *)fpsLabel {
    
    if (!_fpsLabel) {
        _fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(0, 60, 80, 30)];
    }
    return _fpsLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.fpsLabel];
}


@end
