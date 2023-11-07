//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "Masonry.h"


@interface ViewController ()


@property(strong, nonatomic) UILabel *label1;

@property(strong, nonatomic) UILabel *label2;


@end

@implementation ViewController

- (UILabel *)label1 {
    
    if (!_label1) {
        _label1 = UILabel.new;
        _label1.font = [UIFont systemFontOfSize:14.f];
        _label1.backgroundColor = UIColor.orangeColor;
        //首先解决第一个问题，左右2边数据均不足的时候，谁拉伸，这个由HuggingPriority控制。
        //第一个问题
        _label1.text = @"label1";
    }
    return _label1;
}

- (UILabel *)label2 {
    
    if (!_label2) {
        _label2 = UILabel.new;
        _label2.font = [UIFont systemFontOfSize:14.f];
        _label2.backgroundColor = UIColor.lightGrayColor;
        //然后解决第二个问题，左右2边数据都充足的时候，谁收缩，这个由ContentCompressionResistancePriority控制。
        //然后解决第二个问题
        _label2.text = @"label2";
    }
    return _label2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(@20.f);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.label1.mas_right).offset(10.f);
        make.right.equalTo(@(-20.f));
    }];
    
    //设置优先级:当内容太多时，谁缩？默认：UILayoutPriorityDefaultHigh 值越小越缩
//    [self.label1 setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
//    [self.label2 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    //设置优先级:当内容不足时，谁伸？ 值越小越伸
    [self.label1 setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.label2 setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
}





@end
