//
//  TKLoadingHUD.h
//  AnimationTest
//
//  Created by 谭柯 on 16/5/19.
//  Copyright © 2016年 Tank. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TKLoadingStyle) {
    TKLoadingStyleDefault,
    TKLoadingStyleLine,
    TKLoadingStyleBall,
    TKLoadingStyleBallChain
};

@interface TKLoadingHUD : UIView

@property (nonatomic, assign, readonly) NSInteger loadCount;
@property (nonatomic, assign) TKLoadingStyle loadingStyle;

- (instancetype)initWithReferView:(UIView *)referView;

- (instancetype)initWithReferView:(UIView *)referView loadingStyle:(TKLoadingStyle)loadingStyle;

+ (void)showHUDAddedTo:(UIView *)view;
+ (void)showHUDAddedTo:(UIView *)view loadingStyle:(TKLoadingStyle)loadingStyle;

+ (void)hideHUDForView:(UIView *)view;

+ (void)changeloadingStyle:(TKLoadingStyle)loadingStyle ForView:(UIView *)view;

+ (TKLoadingHUD *)subLoadingHUDFromView:(UIView *)view;

@end
