//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "CTMediator.h"
#import "CTMediator+CT_DetailPage.h"

@interface ViewController ()

@property(strong, nonatomic) UIButton *pushBth;

@property(strong, nonatomic) UIButton *businessBtn;

@end

@implementation ViewController

+ (void)load {
    

}

- (UIButton *)pushBth {
    
    if (!_pushBth) {
        _pushBth = [UIButton new];
        [_pushBth setTitle:@"跳转" forState:UIControlStateNormal];
        [_pushBth setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [_pushBth addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushBth;
}

- (UIButton *)businessBtn {
    
    if (!_businessBtn) {
        _businessBtn = [UIButton new];
        [_businessBtn setTitle:@"点击" forState:UIControlStateNormal];
        [_businessBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [_businessBtn addTarget:self action:@selector(businessAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _businessBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pushBth.frame = CGRectMake(0, 0, 80, 30);
    [self.view addSubview:self.pushBth];
    self.pushBth.center = self.view.center;
    self.businessBtn.frame = CGRectMake(self.pushBth.frame.origin.x, CGRectGetMaxY(self.pushBth.frame) + 20.f, 80, 30);
    [self.view addSubview:self.businessBtn];
}

- (void)pushAction {
    UIViewController *vc = [[CTMediator sharedInstance] CTMediator_viewControllerForDetail];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)businessAction {

}

- (void)fetchImageView {
    
}


@end
