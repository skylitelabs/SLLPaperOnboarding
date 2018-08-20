//
//  SLLGestureControl.m
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-20.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import "SLLGestureControl.h"

@implementation SLLGestureControl

- (instancetype)initWithView:(UIView *)view
                    delegate:(id<SLLGestureControlDelegate>)delegate {
    if (self = [super initWithFrame:CGRectZero]) {
        self.delegate = delegate;
        SEL gestureSelector = @selector(swipeHandlerWithGesture:);
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                        action:gestureSelector];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeLeft];
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                         action:gestureSelector];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeRight];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
        [view addSubview:self];
        
        NSLayoutConstraint *cLeft = [NSLayoutConstraint constraintWithItem:self
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:view
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.f
                                                                  constant:0];
        NSLayoutConstraint *cRight = [NSLayoutConstraint constraintWithItem:self
                                                                  attribute:NSLayoutAttributeRight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:view
                                                                  attribute:NSLayoutAttributeRight
                                                                 multiplier:1.f
                                                                   constant:0];
        NSLayoutConstraint *cTop = [NSLayoutConstraint constraintWithItem:self
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:view
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.f
                                                                 constant:0];
        NSLayoutConstraint *cBottom = [NSLayoutConstraint constraintWithItem:self
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:view
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.f
                                                                    constant:0];
        [view addConstraints:@[cLeft, cRight, cBottom, cTop]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [NSException raise:@"InitNotImplemented" format:@"initWithCoder: has not been implemented"];
    return self;
}

- (void)swipeHandlerWithGesture:(UISwipeGestureRecognizer *)gesture {
    if ([self.delegate respondsToSelector:@selector(gestureControlDidSwipeWithDirection:)]) {
        [self.delegate gestureControlDidSwipeWithDirection:gesture.direction];
    }
}

@end
