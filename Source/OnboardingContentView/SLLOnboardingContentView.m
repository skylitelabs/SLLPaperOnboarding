//
//  SLLOnboardingContentView.m
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-14.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import "SLLOnboardingContentView.h"

@interface SLLOnboardingContentView ()

@property (nonatomic, readwrite, nullable, strong) SLLOnboardingContentViewItem *currentItem;

@end

@implementation SLLOnboardingContentView

- (instancetype)initWithItemsCount:(NSInteger)itemsCount
                          delegate:(id<SLLOnboardingContentViewDelegate>)delegate {
    if (self = [super initWithFrame:CGRectZero]) {
        self.delegate = delegate;
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
    self.currentItem = [self createItemAtIndex:0];
}

- (SLLOnboardingContentViewItem *)createItemAtIndex:(NSInteger)index {
    SLLOnboardingItemInfo *info = [self.delegate respondsToSelector:@selector(onboardingItemAtIndex:)] ?
    [self.delegate onboardingItemAtIndex:index] : nil;
    // guard statement
    if (!info) {
        return [SLLOnboardingContentViewItem itemOnView:self];
    }
    SLLOnboardingContentViewItem *item = [SLLOnboardingContentViewItem itemOnView:self];
    if (item.imageView) {
        item.imageView.image = info.informationImage;
    }
    if (item.titleLabel) {
        item.titleLabel.text = info.title;
        item.titleLabel.font = info.titleFont;
        item.titleLabel.textColor = info.titleColor;
    }
    if (item.descriptionLabel) {
        item.descriptionLabel.text = info.desc;
        item.descriptionLabel.font = info.descriptionFont;
        item.descriptionLabel.textColor = info.descriptionColor;
    }
    if ([self.delegate respondsToSelector:@selector(onboardingConfigurationItem:atIndex:)]) {
        [self.delegate onboardingConfigurationItem:item atIndex:index];
    }
    return item;
}

+ (SLLOnboardingContentView *)contentViewOnView:(UIView *)view
                                       delegate:(id<SLLOnboardingContentViewDelegate>)delegate
                                     itemsCount:(NSInteger)itemsCount
                                 bottomConstant:(CGFloat)bottomConstant {
    SLLOnboardingContentView *contentView = [[SLLOnboardingContentView alloc] initWithItemsCount:itemsCount
                                                                                        delegate:delegate];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:contentView];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.f
                                                      constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:0.f
                                                      constant:bottomConstant]];
    return contentView;
}

- (void)hideItemView:(SLLOnboardingContentViewItem *)item
            duration:(double)duration {
    if (!item) {
        return;
    }
    if (item.descriptionBottomConstraint) {
        item.descriptionBottomConstraint.constant -= kDyOffsetAnimation;
    }
    if (item.titleCenterConstraint) {
        item.titleCenterConstraint.constant *= 1.3;
    }
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         item.alpha = 0;
                         [self layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         [item removeFromSuperview];
                     }];
}

- (void)showItemView:(SLLOnboardingContentViewItem *)item
            duration:(double)duration {
    if (item.descriptionBottomConstraint) {
        item.descriptionBottomConstraint.constant = kDyOffsetAnimation;
    }
    if (item.titleCenterConstraint) {
        item.titleCenterConstraint.constant /= 2;
    }
    item.alpha = 0;
    [self layoutIfNeeded];
    
    if (item.descriptionBottomConstraint) {
        item.descriptionBottomConstraint.constant = 0;
    }
    if (item.titleCenterConstraint) {
        item.titleCenterConstraint.constant *= 2;
    }
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         item.alpha = 0;
                         item.alpha = 1;
                         [self layoutIfNeeded];
                     }
                     completion:nil];
}

- (void)setCurrentItemToIndex:(NSInteger)index
                     animated:(BOOL)animated {
    SLLOnboardingContentViewItem *showItem = [self createItemAtIndex:index];
    [self showItemView:showItem
              duration:kShowDuration];
    [self hideItemView:self.currentItem
              duration:kHideDuration];
    self.currentItem = showItem;
}

@end
