//
//  TKBallLoadView.m
//  AnimationTest
//
//  Created by 谭柯 on 16/5/19.
//  Copyright © 2016年 Tank. All rights reserved.
//

#import "TKBallLoadView.h"

#define AnimationDuration 0.5

@implementation TKBallLoadView

- (instancetype)init{
    self = [super init];
    
    self.tintColor = [UIColor whiteColor];
    
    return self;
}

- (void)layoutSubviews{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [super layoutSubviews];
    [self startAnimation];
}

- (void)startAnimation{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.layer removeAllAnimations];
    
    CGFloat ballOriginWidth = self.frame.size.width/5;
    
    //大小变化动画
    CABasicAnimation *smallAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    smallAnimation.fromValue = @(1.0);
    smallAnimation.toValue = @(0.8);
    smallAnimation.duration = AnimationDuration;
    smallAnimation.removedOnCompletion = NO;
    smallAnimation.fillMode = kCAFillModeForwards;
    smallAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *bigAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    bigAnimation.fromValue = @(0.8);
    bigAnimation.toValue = @(1.0);
    bigAnimation.duration = AnimationDuration;
    bigAnimation.beginTime = AnimationDuration*2;
    bigAnimation.removedOnCompletion = NO;
    bigAnimation.fillMode = kCAFillModeForwards;
    bigAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //中间的球
    CALayer *ballLayer1 = [CALayer layer];
    ballLayer1.cornerRadius = ballOriginWidth/2;
    ballLayer1.backgroundColor = self.tintColor.CGColor;
    ballLayer1.bounds = CGRectMake(0, 0, ballOriginWidth, ballOriginWidth);
    ballLayer1.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self.layer addSublayer:ballLayer1];
    
    CAAnimationGroup *ball1AnimationGroup = [CAAnimationGroup animation];
    ball1AnimationGroup.animations = @[smallAnimation,bigAnimation];
    ball1AnimationGroup.duration = 3.5*AnimationDuration;
    ball1AnimationGroup.repeatCount = INTMAX_MAX;
    
    [ballLayer1 addAnimation:ball1AnimationGroup forKey:nil];
    
    //左边的球
    CALayer *ballLayer2 = [CALayer layer];
    ballLayer2.cornerRadius = ballOriginWidth/2;
    ballLayer2.backgroundColor = self.tintColor.CGColor;
    ballLayer2.bounds = CGRectMake(0, 0, ballOriginWidth, ballOriginWidth);
    ballLayer2.position = CGPointMake(self.frame.size.width/2-ballOriginWidth, self.frame.size.height/2);
    [self.layer addSublayer:ballLayer2];
    
    CABasicAnimation *ball2PositionAni = [CABasicAnimation animationWithKeyPath:@"position.x"];
    ball2PositionAni.fromValue = @(self.frame.size.width/2-ballOriginWidth);
    ball2PositionAni.toValue = @(ballOriginWidth/2);
    ball2PositionAni.duration = AnimationDuration;
    ball2PositionAni.removedOnCompletion = NO;
    ball2PositionAni.beginTime = 0;
    ball2PositionAni.fillMode = kCAFillModeForwards;
    ball2PositionAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *ball2PositionBackAni = [CABasicAnimation animationWithKeyPath:@"position.x"];
    ball2PositionBackAni.fromValue = @(ballOriginWidth/2);
    ball2PositionBackAni.toValue = @(self.frame.size.width/2-ballOriginWidth);
    ball2PositionBackAni.duration = AnimationDuration;
    ball2PositionBackAni.removedOnCompletion = NO;
    ball2PositionBackAni.beginTime = AnimationDuration*2;
    ball2PositionBackAni.fillMode = kCAFillModeForwards;
    ball2PositionBackAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *ball2AnimationGroup = [CAAnimationGroup animation];
    ball2AnimationGroup.animations = @[ball2PositionAni,ball2PositionBackAni,smallAnimation,bigAnimation];
    ball2AnimationGroup.duration = 3.5*AnimationDuration;
    ball2AnimationGroup.repeatCount = INTMAX_MAX;
    
    [ballLayer2 addAnimation:ball2AnimationGroup forKey:nil];
    
    //右边的球
    CALayer *ballLayer3 = [CALayer layer];
    ballLayer3.cornerRadius = ballOriginWidth/2;
    ballLayer3.backgroundColor = self.tintColor.CGColor;
    ballLayer3.bounds = CGRectMake(0, 0, ballOriginWidth, ballOriginWidth);
    ballLayer3.position = CGPointMake(self.frame.size.width/2+ballOriginWidth, self.frame.size.height/2);
    [self.layer addSublayer:ballLayer3];
    
    CABasicAnimation *ball3PositionAni = [CABasicAnimation animationWithKeyPath:@"position.x"];
    ball3PositionAni.fromValue = @(self.frame.size.width/2+ballOriginWidth);
    ball3PositionAni.toValue = @(self.frame.size.width - ballOriginWidth/2);
    ball3PositionAni.duration = AnimationDuration;
    ball3PositionAni.removedOnCompletion = NO;
    ball3PositionAni.beginTime = 0;
    ball3PositionAni.fillMode = kCAFillModeForwards;
    ball3PositionAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *ball3PositionBackAni = [CABasicAnimation animationWithKeyPath:@"position.x"];
    ball3PositionBackAni.fromValue = @(self.frame.size.width - ballOriginWidth/2);
    ball3PositionBackAni.toValue = @(self.frame.size.width/2+ballOriginWidth);
    ball3PositionBackAni.duration = AnimationDuration;
    ball3PositionBackAni.removedOnCompletion = NO;
    ball3PositionBackAni.beginTime = AnimationDuration*2;
    ball3PositionBackAni.fillMode = kCAFillModeForwards;
    ball3PositionBackAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *ball3AnimationGroup = [CAAnimationGroup animation];
    ball3AnimationGroup.animations = @[ball3PositionAni,ball3PositionBackAni,smallAnimation,bigAnimation];
    ball3AnimationGroup.duration = 3.5*AnimationDuration;
    ball3AnimationGroup.repeatCount = INTMAX_MAX;
    
    [ballLayer3 addAnimation:ball3AnimationGroup forKey:nil];
    
    //整体旋转动画
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.beginTime = AnimationDuration;
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(2*M_PI);
    rotationAnimation.duration = AnimationDuration*2;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *rotationBackAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationBackAnimation.beginTime = AnimationDuration*2;
    rotationBackAnimation.fromValue = @(M_PI);
    rotationBackAnimation.toValue = @(M_PI*2);
    rotationBackAnimation.duration = AnimationDuration;
    rotationBackAnimation.removedOnCompletion = NO;
    rotationBackAnimation.fillMode = kCAFillModeForwards;
    rotationBackAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CAAnimationGroup *rotationAnimationGroup = [CAAnimationGroup animation];
    rotationAnimationGroup.animations = @[rotationAnimation];
    rotationAnimationGroup.duration = AnimationDuration*3.5;
    rotationAnimationGroup.repeatCount = INTMAX_MAX;
    
    [self.layer addAnimation:rotationAnimationGroup forKey:nil];
}

@end
