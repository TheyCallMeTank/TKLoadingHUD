//
//  TKlineLoadView.m
//  AnimationTest
//
//  Created by 谭柯 on 16/5/20.
//  Copyright © 2016年 Tank. All rights reserved.
//

#import "TKlineLoadView.h"

#define AnimationDuration 1

@implementation TKlineLoadView

- (instancetype)init{
    self = [super init];
    
    self.tintColor = [UIColor whiteColor];
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self startAnimation];
}

- (void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    [self startAnimation];
}

- (void)startAnimation{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.layer removeAllAnimations];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [self.layer addSublayer:shapeLayer];
    shapeLayer.strokeColor = self.tintColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = self.bounds.size.width/8;
    shapeLayer.lineCap = kCALineCapRound;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.bounds.size.width/2 startAngle:M_PI_2 endAngle:M_PI_2 + 2*M_PI clockwise:YES];
    shapeLayer.path = path.CGPath;
    
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.duration = AnimationDuration;
    startAnimation.fromValue = @(0);
    startAnimation.toValue = @(1);
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.duration = AnimationDuration;
    endAnimation.fromValue = @(0);
    endAnimation.toValue = @(1);
    endAnimation.beginTime = AnimationDuration;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[startAnimation,endAnimation];
    group.repeatCount = INT64_MAX;
    group.duration = AnimationDuration * 2;
    group.autoreverses = NO;
    
    [shapeLayer addAnimation:group forKey:nil];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @0;
    rotationAnimation.toValue = @(2*M_PI);
    rotationAnimation.duration = AnimationDuration*2;
    rotationAnimation.repeatCount = INTMAX_MAX;
    
    [self.layer addAnimation:rotationAnimation forKey:nil];
}

@end
