//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "Masonry.h"
#import "MyView.h"
#import "AView.h"
#import "BView.h"
#import "CView.h"
#import "DView.h"
#import "EView.h""


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AView *aView = [AView new];
    aView.backgroundColor = UIColor.grayColor;
    aView.title = @"A";
    [self.view addSubview:aView];
    [aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(270.f);
        make.center.equalTo(self.view);
    }];
    
    BView *bView = [BView new];
    bView.backgroundColor = UIColor.greenColor;
    bView.title = @"B";
    [aView addSubview:bView];
    [bView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(140.f);
        make.top.mas_equalTo(20.f);
        make.left.mas_equalTo(20.f);
    }];
    
    CView *cView = [CView new];
    cView.backgroundColor = UIColor.orangeColor;
    cView.title = @"C";
    [bView addSubview:cView];
    [cView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60.f);
        make.top.mas_equalTo(20.f);
        make.left.mas_equalTo(20.f);
    }];
    
    DView *dView = [DView new];
    dView.backgroundColor = UIColor.redColor;
    dView.title = @"D";
    [aView addSubview:dView];
    [dView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(140.f);
        make.right.mas_equalTo(-20.f);
        make.bottom.mas_equalTo(-20.f);
    }];
    
    EView *eView = [EView new];
    eView.backgroundColor = UIColor.blueColor;
    eView.title = @"E";
    [dView addSubview:eView];
    [eView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(140.f);
        make.height.mas_equalTo(60.f);
        make.left.mas_equalTo(-20.f);
        make.top.mas_equalTo(-20.f);
    }];
    
    UIImageView *img;
    img.userInteractionEnabled;
}

@end
