//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "MyDetailViewController.h"
#import "MGJRouter.h"
#import "Masonry.h"

@interface ViewController ()

@property(nonatomic, strong) UILabel *label;

@end

@implementation ViewController

+ (void)initialize {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSDictionary *info = @{@"firstName": @"Brett",@"vc":self,@"block":^(NSString *text){
        self.label.text = text;
    }};
    [MGJRouter openURL:@"MGJ://detail" withUserInfo:info completion:^{
        NSLog(@"___completion___");
    }];
    
}
- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textColor = UIColor.lightGrayColor;
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end
