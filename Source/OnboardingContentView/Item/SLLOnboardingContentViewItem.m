//
//  SLLOnboardingContentViewItem.m
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-13.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import "SLLOnboardingContentViewItem.h"

@implementation SLLOnboardingContentViewItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [NSException raise:@"InitNotImplemented" format:@"initWithCoder: is not implemented."];
    return self;
}

- (void)commonInit {
    UILabel *titleLabel = [self createTitleLabelOnView:self];
    UILabel *descriptionLabel = [self createDescriptionLabelOnView:self];
    UIImageView *imageView = [self createImageOnView:self];
    
    self.titleCenterConstraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:imageView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.f
                                                               constant:50.f];
    [self addConstraint:self.titleCenterConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:titleLabel
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.f
                                                      constant:10.f]];
    self.titleLabel = titleLabel;
    self.descriptionLabel = descriptionLabel;
    self.imageView = imageView;
}

- (UILabel *)createTitleLabelOnView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"AvenirNext-Bold" size:36];
    label.textAlignment = NSTextAlignmentCenter;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:label];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.f
                                                      constant:10000]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.f
                                                      constant:0]];
    NSLog(@"%@", view.trailingAnchor);
    NSLog(@"%@", view.constraints);
    return label;
}

- (UILabel *)createDescriptionLabelOnView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:label];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.f
                                                      constant:10000]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.f
                                                      constant:30]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.f
                                                      constant:-30]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.f
                                                      constant:0]];
    self.descriptionBottomConstraint = [NSLayoutConstraint constraintWithItem:label
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:view
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1.f
                                                                     constant:0];
    [view addConstraint:self.descriptionBottomConstraint];
    return label;
}

- (UILabel *)createLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    return label;
}

- (UIImageView *)createImageOnView:(UIView *)view {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:imageView];
    
    self.informationImageWidthConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                                        attribute:NSLayoutAttributeWidth
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.f
                                                                         constant:188.f];
    self.informationImageHeightConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1.f
                                                                          constant:188.f];
    [view addConstraint:self.informationImageWidthConstraint];
    [view addConstraint:self.informationImageHeightConstraint];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.f
                                                      constant:0]];
    return imageView;
}

+ (SLLOnboardingContentViewItem *)itemOnView:(UIView *)view {
    SLLOnboardingContentViewItem *item = [[SLLOnboardingContentViewItem alloc] initWithFrame:CGRectZero];
    item.backgroundColor = [UIColor clearColor];
    item.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addSubview:item];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:item
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.f
                                                      constant:10000.f]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:item
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:item
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:item
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:item
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.f
                                                      constant:0]];
    return item;
}

@end
