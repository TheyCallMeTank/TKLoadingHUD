//
//  TKLoadingHUD.m
//  AnimationTest
//
//  Created by 谭柯 on 16/5/19.
//  Copyright © 2016年 Tank. All rights reserved.
//

#import "TKLoadingHUD.h"
#import "TKlineLoadView.h"
#import "TKBallLoadView.h"
#import "TKBallChainLoadView.h"

@interface TKLoadingHUD()

@property (nonatomic, weak) UIView *referView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *loadingView;

@end

@implementation TKLoadingHUD

#pragma mark - 初始化

- (instancetype)initWithReferView:(UIView *)referView loadingStyle:(TKLoadingStyle)loadingStyle{
    self = [super init];
    
    _loadingStyle = loadingStyle;
    self.referView = referView;
    
    return self;
}

- (instancetype)initWithReferView:(UIView *)referView{
    return [self initWithReferView:referView loadingStyle:TKLoadingStyleDefault];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!self.contentView) {
        self.contentView = [UIView new];
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
        self.contentView.layer.cornerRadius = 10.0;
        [self addSubview:self.contentView];
    }
    
    CGFloat contentWidth = 80;
    [self.contentView setFrame:CGRectMake(self.bounds.size.width/2 - contentWidth/2, self.bounds.size.height/2 - contentWidth/2 - 32, contentWidth, contentWidth)];
    
    [self setLoadingView];
}

#pragma mark - 设置Loading类型

- (void)setLoadingStyle:(TKLoadingStyle)loadingStyle{
    _loadingStyle = loadingStyle;
    [self setLoadingView];
}

- (void)setLoadingView{
    if (!self.contentView) {
        return;
    }
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (self.loadingStyle) {
        case TKLoadingStyleBall:
            self.loadingView = [TKBallLoadView new];
            break;
        case TKLoadingStyleLine:
            self.loadingView = [TKlineLoadView new];
            break;
        case TKLoadingStyleBallChain:
            self.loadingView = [TKBallChainLoadView new];
            break;
            
        default:{
            UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            [indicatorView startAnimating];
            self.loadingView = indicatorView;
        }
            break;
    }
    [self.contentView addSubview:self.loadingView];
    
    switch (self.loadingStyle) {
        case TKLoadingStyleBall:
            [self.loadingView setBounds:CGRectMake(0, 0, self.contentView.frame.size.width*0.8, self.contentView.frame.size.height*0.8)];
            break;
        case TKLoadingStyleBallChain:
            [self.loadingView setBounds:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
            break;
        default:
            [self.loadingView setBounds:CGRectMake(0, 0, self.contentView.frame.size.width*0.4, self.contentView.frame.size.height*0.4)];
            break;
    }
    self.loadingView.center = CGPointMake(self.contentView.frame.size.width/2, self.contentView.frame.size.height/2);
}

+ (void)changeloadingStyle:(TKLoadingStyle)loadingStyle ForView:(UIView *)view{
    TKLoadingHUD *hud = [self subLoadingHUDFromView:view];
    if (hud) {
        hud.loadingStyle = loadingStyle;
    }
}

#pragma mark - 显示，隐藏

- (void)show{
    [self.referView addSubview:self];
    
    [self setFrame:self.referView.bounds];
    
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)hide{
    self.alpha = 1;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setLoadCount:(NSInteger)loadCount{
    if (loadCount == 0 && _loadCount > 0) {
        [self hide];
    }
    if (_loadCount == 0 && loadCount > 0) {
        [self show];
    }
    _loadCount = loadCount;
}

+ (void)showHUDAddedTo:(UIView *)view{
    [self showHUDAddedTo:view loadingStyle:TKLoadingStyleDefault];
}

+ (void)showHUDAddedTo:(UIView *)view loadingStyle:(TKLoadingStyle)loadingStyle{
    TKLoadingHUD *hud = [self subLoadingHUDFromView:view];
    if (loadingStyle != hud.loadingStyle) {
        hud.loadingStyle = loadingStyle;
    }
    if (!hud) {
        hud = [[TKLoadingHUD alloc] initWithReferView:view loadingStyle:loadingStyle];
    }
    hud.loadCount++;
}

+ (void)hideHUDForView:(UIView *)view{
    TKLoadingHUD *hud = [self subLoadingHUDFromView:view];
    if (hud) {
        hud.loadCount--;
    }
}

+ (TKLoadingHUD *)subLoadingHUDFromView:(UIView *)view{
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[TKLoadingHUD class]]) {
            return (TKLoadingHUD *)subView;
        }
    }
    return nil;
}

@end
