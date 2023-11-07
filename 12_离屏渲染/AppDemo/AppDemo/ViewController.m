//
//  ViewController.m
//  AppDemo
//
//  Created by Jentle on 2021/11/26.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@property(nonatomic, strong) UIScrollView *scrollView;

@property(nonatomic, strong) UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.width.equalTo(self.scrollView);
    }];
    CGFloat WH = 80;
    UIView *v1;
    {
        UIView *shadowView = UIView.new;
        v1 = shadowView;
        shadowView.backgroundColor = UIColor.orangeColor;
        [self.contentView addSubview:shadowView];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20.f);
            make.width.height.mas_equalTo(WH);
            make.centerX.equalTo(self.contentView);
        }];
        shadowView.layer.shadowColor = UIColor.blackColor.CGColor;
        shadowView.layer.shadowOpacity = 0.5;
        shadowView.layer.shadowRadius = 5;
        shadowView.layer.shadowOffset = CGSizeMake(5, 5);
        //指定了阴影的路径，就可以避免阴影导致的离屏渲染
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowView.bounds];
        shadowView.layer.shadowPath = path.CGPath;
        
    }
    
    
    UIView *v2;
    {
        //当只设置backgroundColor、border，而contents中没有子视图时，无论maskToBounds / clipsToBounds是true还是false，都不会触发离屏渲染
        UIView *shadowView = UIView.new;
        v2 = shadowView;
        shadowView.backgroundColor = UIColor.orangeColor;
        [self.contentView addSubview:shadowView];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(v1.mas_bottom).offset(20.f);
            make.width.height.centerX.equalTo(v1);
        }];
        shadowView.layer.borderColor = UIColor.blackColor.CGColor;
        shadowView.layer.borderWidth = 1.5;
        shadowView.layer.masksToBounds = YES;
        shadowView.layer.cornerRadius = 10;
        
    }
    
    UIView *v3;
    {
        //当contents中有子视图时，此时设置 cornerRadius+maskToBounds / clipsToBounds,就会触发离屏渲染
        //但是这种情况在UIImageView中并不适用，当UIImageView中只设置图片+maskToBounds / clipsToBounds是不会触发离屏渲染
        UIButton *shadowView = UIButton.new;
        v3 = shadowView;
        shadowView.backgroundColor = UIColor.orangeColor;
        [self.contentView addSubview:shadowView];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(v2.mas_bottom).offset(20.f);
            make.width.height.centerX.equalTo(v2);
        }];
        shadowView.layer.borderColor = UIColor.blackColor.CGColor;
        shadowView.layer.borderWidth = 1.5;
//        shadowView.layer.masksToBounds = YES;
        shadowView.clipsToBounds = YES;
        shadowView.layer.cornerRadius = 10;
        [shadowView setTitle:@"我是按钮" forState:UIControlStateNormal];
//        [shadowView setImage:[UIImage imageNamed:@"download.jpg"] forState:UIControlStateNormal];
        [self.contentView addSubview:shadowView];
    }
    
    UIView *v4;
    {
        //但是这种情况在UIImageView中并不适用，当UIImageView中只设置图片+maskToBounds / clipsToBounds是不会触发离屏渲染
        //如果此时再加上背景色，就会触发离屏渲染
        UIImageView *shadowView = UIImageView.new;
        v4 = shadowView;
//        shadowView.backgroundColor = UIColor.orangeColor;
        [self.contentView addSubview:shadowView];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(v3.mas_bottom).offset(20.f);
            make.width.height.centerX.equalTo(v3);
        }];
        shadowView.layer.borderColor = UIColor.blackColor.CGColor;
        shadowView.layer.masksToBounds = YES;
        shadowView.layer.cornerRadius = 10;
        shadowView.image = [UIImage imageNamed:@"download.jpg"];
        [self.contentView addSubview:shadowView];
    }
    
    UIView *v5;
    {
        //但是这种情况在UIImageView中并不适用，当UIImageView中只设置图片+maskToBounds / clipsToBounds是不会触发离屏渲染
        //如果此时再加上背景色，就会触发离屏渲染
        UIImageView *shadowView = UIImageView.new;
        v5 = shadowView;
//        shadowView.backgroundColor = UIColor.orangeColor;
        [self.contentView addSubview:shadowView];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(v4.mas_bottom).offset(20.f);
            make.width.height.centerX.equalTo(v4);
            make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).offset(-20.f);
        }];
//        shadowView.layer.borderColor = UIColor.blackColor.CGColor;
//        shadowView.layer.masksToBounds = YES;
//        shadowView.layer.cornerRadius = 10;
        shadowView.image = [UIImage imageNamed:@"download.jpg"];
        [self.contentView addSubview:shadowView];
        
        
        [self.contentView layoutIfNeeded];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [self.contentView layoutIfNeeded];
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:v5.bounds];
        shapeLayer.path = bezierPath.CGPath;
        shadowView.layer.mask = shapeLayer;
    }
    
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = UIScrollView.new;
        _scrollView.frame = CGRectMake(0, 80, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
        [self.view addSubview:_scrollView];
    }
    return  _scrollView;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = UIColor.lightGrayColor;
        [self.scrollView addSubview:_contentView];
    }
    return _contentView;
}


@end
