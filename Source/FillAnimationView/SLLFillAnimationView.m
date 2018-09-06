//
//  SLLFillAnimationView.m
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-14.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import "SLLFillAnimationView.h"

@interface SLLFillAnimationView () <CAAnimationDelegate>

@end

@implementation SLLFillAnimationView

+ (SLLFillAnimationView *)animationOnView:(UIView *)view
                                    color:(UIColor *)color {
    SLLFillAnimationView *animationView = [[SLLFillAnimationView alloc] initWithFrame:CGRectZero];
    animationView.backgroundColor = color;
    animationView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:animationView];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:animationView
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:animationView
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:animationView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:animationView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.f
                                                      constant:0]];
    return animationView;
}

- (void)fillAnimationWithColor:(UIColor *)color
                centerPosition:(CGPoint)centerPosition
                      duration:(double)duration {
    CGFloat radius = MAX(self.bounds.size.width, self.bounds.size.height) * 1.5;
    CAShapeLayer *circle = [self createCircleLayerAtPosition:centerPosition
                                                       color:color];
    CABasicAnimation *animation = [self animationToRadius:radius
                                                   center:centerPosition
                                                 duration:duration];
    [animation setValue:circle forKey:kSLLCircleConstant];
    [circle addAnimation:animation forKey:nil];
}

- (CAShapeLayer *)createCircleLayerAtPosition:(CGPoint)position
                                        color:(UIColor *)color {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:position
                                                        radius:1.f
                                                    startAngle:0.f
                                                      endAngle:(2.f * M_PI)
                                                     clockwise:YES];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = [path CGPath];
    layer.fillColor = [color CGColor];
    layer.shouldRasterize = YES;
    
    [self.layer addSublayer:layer];
    return layer;
}

#pragma mark - Animation / Animation Delegate

- (CABasicAnimation *)animationToRadius:(CGFloat)radius
                                 center:(CGPoint)center
                               duration:(double)duration {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:0.f
                                                      endAngle:(2.f * M_PI)
                                                     clockwise:YES];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kSLLPathConstant];
    animation.duration = duration;
    animation.toValue = (__bridge id)[path CGPath];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    CAShapeLayer *circleLayer = [anim valueForKey:kSLLCircleConstant];
    if (!circleLayer) {
        return;
    }
    self.layer.backgroundColor = circleLayer.fillColor;
    [circleLayer removeFromSuperlayer];
}

@end
