//
//  SLLPageView.m
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-16.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import "SLLPageView.h"

@interface SLLPageView ()

@property (nonatomic, readwrite, nullable, strong) NSLayoutConstraint *containerX;

@end

@implementation SLLPageView

- (instancetype)initWithFrame:(CGRect)frame
                   itemsCount:(NSInteger)itemsCount
                       radius:(CGFloat)radius
               selectedRadius:(CGFloat)selectedRadius
                    itemColor:(UIColor *(^_Nullable)(NSInteger index))itemColor {
    if (self = [super initWithFrame:frame]) {
        self.itemsCount = itemsCount;
        self.itemRadius = radius;
        self.selectedItemRadius = selectedRadius;
        self.itemColor = itemColor;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [NSException raise:@"InitNotImplemented" format:@"initWithCoder: has not been implemented"];
    return self;
}

- (UIView *)hitTest:(CGPoint)point
          withEvent:(UIEvent *)event {
    SLLPageContainer *containerView = self.containerView;
    NSArray<SLLPageViewItem *> *items;
    if (containerView) {
        items = containerView.items;
    }
    if (!items || !containerView) {
        return nil;
    }
    for (SLLPageViewItem *item in items) {
        CGRect frame = CGRectInset(item.frame, -10, -10);
        if (CGRectContainsPoint(frame, point)) {
            return item;
        }
    }
    return nil;
}

+ (SLLPageView *)pageViewOnView:(UIView *)view
                     itemsCount:(NSInteger)itemsCount
                 bottomConstant:(CGFloat)bottomConstant
                         radius:(CGFloat)radius
                 selectedRadius:(CGFloat)selectedRadius
                      itemColor:(UIColor * (^_Nullable)(NSInteger index))itemColor {
    SLLPageView *pageView = [[SLLPageView alloc] initWithFrame:CGRectZero
                                                    itemsCount:itemsCount
                                                        radius:radius
                                                selectedRadius:selectedRadius
                                                     itemColor:itemColor];
    pageView.translatesAutoresizingMaskIntoConstraints = NO;
    pageView.alpha = 0.4;
    [view addSubview:pageView];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.f
                                                      constant:bottomConstant]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:pageView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:0.f
                                                      constant:30.f]];
    return pageView;
}

- (void)setCurrentIndexToIndex:(NSInteger)index
                      animated:(BOOL)animated {
    if (((index >= 0) && (index < self.itemsCount)) && self.containerView) {
        [self.containerView setCurrentIndexToIndex:index
                                          duration:(self.duration * 0.5)
                                          animated:animated];
        [self moveContainerToIndex:index
                          animated:animated
                          duration:self.duration];
    }
}

- (CGPoint)positionItemIndex:(NSInteger)index
                      onView:(UIView *)view {
    if (((index >= 0) && (index < self.itemsCount)) &&
        self.containerView &&
        self.containerView.items &&
        self.containerView.items[index]) {
        UIImageView *currentItem = self.containerView.items[index].imageView;
        if (currentItem) {
            CGPoint pos = [currentItem convertPoint:currentItem.center
                                             toView:view];
            return pos;
        }
    }
    return CGPointZero;
}

- (void)commonInit {
    self.containerView = [self createContainerView];
    [self setCurrentIndexToIndex:0
                        animated:NO];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setConfiguration:(void (^)(SLLPageViewItem * _Nullable, NSInteger))configuration {
    _configuration = configuration;
    if (self.containerView && self.containerView.items) {
        [self configurePageItems:self.containerView.items];
    }
}

#pragma mark - Create

- (SLLPageContainer *)createContainerView {
    SLLPageContainer *pageControl = [[SLLPageContainer alloc] initWithRadius:self.itemRadius
                                                              selectedRadius:self.selectedItemRadius
                                                                       space:self.space
                                                                  itemsCount:self.itemsCount
                                                                   itemColor:self.itemColor];
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:pageControl];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pageControl
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.f
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pageControl
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.f
                                                      constant:0]];
    self.containerX = [NSLayoutConstraint constraintWithItem:pageControl
                                                   attribute:NSLayoutAttributeCenterX
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self
                                                   attribute:NSLayoutAttributeCenterX
                                                  multiplier:1.f
                                                    constant:0];
    [self addConstraint:self.containerX];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:pageControl
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:0.f
                                                      constant:(self.selectedItemRadius * 2) +
                                                               (self.itemsCount - 1) +
                                                               (self.space * (self.itemsCount - 1))]];
    return pageControl;
}

- (void)configurePageItems:(NSArray<SLLPageViewItem *> *)items {
    if (!items || !self.configuration) {
        return;
    }
    [items enumerateObjectsUsingBlock:^(SLLPageViewItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.configuration(obj, idx);
    }];
}

#pragma mark - Animation

- (void)moveContainerToIndex:(NSInteger)index
                    animated:(BOOL)animated
                    duration:(double)duration {
    if (!self.containerX) {
        return; // guard
    }
    CGFloat containerWidth = ((self.itemsCount + 1) * self.selectedItemRadius) +
                             (self.space * (self.itemsCount - 1));
    CGFloat toValue = (containerWidth / 2.f) - self.selectedItemRadius -
                      ((self.selectedItemRadius + self.space) * index);
    self.containerX.constant = toValue;
    if (animated) {
        [UIView animateWithDuration:self.duration
                              delay:0
                            options:0
                         animations:^{
                             [self layoutIfNeeded];
                         }
                         completion:nil];
    } else {
        [self layoutIfNeeded];
    }
}

@end
