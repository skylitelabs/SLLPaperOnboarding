//
//  SLLPageViewItem.m
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-15.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import "SLLPageViewItem.h"

@implementation SLLPageViewItem

- (instancetype)initWithRadius:(CGFloat)radius
                     itemColor:(UIColor *)itemColor
                selectedRadius:(CGFloat)selectedRadius
                     lineWidth:(CGFloat)lineWidth
                      isSelect:(BOOL)isSelect {
    if (self = [super initWithFrame:CGRectZero]) {
        self.itemColor = itemColor;
        self.lineWidth = lineWidth;
        self.circleRadius = radius;
        self.selectedCircleRadius = selectedRadius;
        self.select = isSelect;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [NSException raise:@"InitNotImplemented" format:@"initWithCoder: has not been implemented"];
    return self;
}

- (void)animationSelected:(BOOL)selected
                 duration:(double)duration
                fillColor:(BOOL)fillColor {
    CGFloat toAlpha = selected ? 1 : 0;
    [self imageAlphaAnimationToValue:toAlpha
                            duration:duration];
    
    CGFloat currentRadius = selected ? self.selectedCircleRadius : self.circleRadius;
    CABasicAnimation *scaleAnimation = [self circleScaleAnimationToRadius:currentRadius - (self.lineWidth / 2.f)
                                                                 duration:duration];
    UIColor *toColor = fillColor ? self.itemColor : [UIColor clearColor];
    CABasicAnimation *colorAnimation = [self circleBackgroundAnimationToColor:toColor
                                                                     duration:duration];
    
    if (self.circleLayer) {
        [self.circleLayer addAnimation:scaleAnimation forKey:nil];
        [self.circleLayer addAnimation:colorAnimation forKey:nil];
    }
}

#pragma mark - Configuration

- (void)commonInit {
    self.centerView = [self createBorderView];
    self.imageView = [self createImageView];
}

- (UIView *)createBorderView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor blueColor];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    
    // build circle layer
    CGFloat currentRadius = self.select ? self.selectedCircleRadius : self.circleRadius;
    CAShapeLayer *circleLayer = [self createCircleLayerWithRadius:currentRadius
                                                        lineWidth:self.lineWidth];
    [view.layer addSublayer:circleLayer];
    self.circleLayer = circleLayer;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.f
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.f
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.f
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.f
                                                      constant:0]];
    return view;
}

- (CAShapeLayer *)createCircleLayerWithRadius:(CGFloat)radius
                                    lineWidth:(CGFloat)lineWidth {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointZero
                                                        radius:radius - (lineWidth / 2.f)
                                                    startAngle:0
                                                      endAngle:(2.f * M_PI)
                                                     clockwise:YES];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = [path CGPath];
    layer.lineWidth = lineWidth;
    layer.strokeColor = [self.itemColor CGColor];
    layer.fillColor = [[UIColor clearColor] CGColor];
    return layer;
}

- (UIImageView *)createImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.alpha = self.select ? 1 : 0;
    [self addSubview:imageView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.f
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.f
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.f
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.f
                                                      constant:0]];
    return imageView;
}

#pragma mark - Animations

- (CABasicAnimation *)circleScaleAnimationToRadius:(CGFloat)radius
                                          duration:(double)duration {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointZero
                                                        radius:radius
                                                    startAngle:0
                                                      endAngle:(2.f * M_PI)
                                                     clockwise:YES];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = duration;
    animation.toValue = (__bridge id)[path CGPath];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

- (CABasicAnimation *)circleBackgroundAnimationToColor:(UIColor *)color
                                              duration:(double)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    animation.duration = duration;
    animation.toValue = (__bridge id)[color CGColor];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return animation;
}

- (void)imageAlphaAnimationToValue:(CGFloat)value
                          duration:(double)duration {
    [UIView animateWithDuration:duration
                          delay:0
                        options:0
                     animations:^{
                         if (self.imageView) {
                             self.imageView.alpha = value;
                         }
                     }
                     completion:nil];
}

@end
