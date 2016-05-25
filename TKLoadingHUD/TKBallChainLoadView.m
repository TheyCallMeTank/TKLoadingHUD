//
//  TKBallChainLoadView.m
//  AnimationTest
//
//  Created by 谭柯 on 16/5/20.
//  Copyright © 2016年 Tank. All rights reserved.
//

#import "TKBallChainLoadView.h"

#define AnimationDuration 2.0
#define BallCount 5

@implementation TKBallChainLoadView

- (instancetype)init{
    self = [super init];
    
    _tintColor = [UIColor whiteColor];
    
    return self;
}

- (void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    [self startAnimation];
}

- (void)layoutSubviews{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [super layoutSubviews];
    [self startAnimation];
}

- (void)startAnimation{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.layer removeAllAnimations];
    
    CGFloat ballWidth = self.bounds.size.width/10;
    
    for (NSInteger i=1; i<BallCount+1; i++) {
        CALayer *ballLayer = [CALayer layer];
        ballLayer.backgroundColor = self.tintColor.CGColor;
        ballLayer.frame = CGRectMake(-ballWidth, self.bounds.size.height/2-ballWidth/2, ballWidth, ballWidth);
        ballLayer.cornerRadius = ballWidth/2;
        
        [self.layer addSublayer:ballLayer];
        
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
        positionAnimation.duration = AnimationDuration;
        positionAnimation.values = @[@(-ballWidth),
                                     @(self.bounds.size.width/3),
                                     @((self.bounds.size.width*2)/3),
                                     @(self.bounds.size.width + ballWidth)];
        positionAnimation.keyTimes = @[@0,@0.25,@0.75,@1.0];
        positionAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        CAKeyframeAnimation *positionBackAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
        positionBackAnimation.duration = AnimationDuration;
        positionBackAnimation.beginTime = AnimationDuration*1.5;
        positionBackAnimation.values = @[@(self.bounds.size.width + ballWidth),
                                         @((self.bounds.size.width*2)/3),
                                         @(self.bounds.size.width/3),@(-ballWidth)];
        positionBackAnimation.keyTimes = @[@0,@0.25,@0.75,@1.0];
        positionBackAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        CAAnimationGroup *positionAnimationGroup = [CAAnimationGroup animation];
        CGFloat beginTime = i*(AnimationDuration/6);
        positionAnimationGroup.beginTime = beginTime;
        positionAnimationGroup.animations = @[positionAnimation,positionBackAnimation];
        positionAnimationGroup.duration = AnimationDuration*3;
        positionAnimationGroup.repeatCount = INTMAX_MAX;
        
        [ballLayer addAnimation:positionAnimationGroup forKey:nil];
    }
}

@end
