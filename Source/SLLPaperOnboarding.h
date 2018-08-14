//
//  SLLPaperOnboarding.h
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-13.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLLOnboardingItemInfo.h"

NS_ASSUME_NONNULL_BEGIN

@class SLLPaperOnboarding;

@protocol SLLPaperOnboardingDataSource <NSObject>

- (NSInteger)onboardingItemsCount;
- (nullable SLLOnboardingItemInfo *)onboardingItemAtIndex:(NSInteger)index;
- (nullable UIColor *)onboardingPageItemColorAtIndex:(NSInteger)index;
- (CGFloat)onboardingPageItemRadius;
- (CGFloat)onboardingPageItemSelectedRadius;

@end

@protocol SLLPaperOnboardingDelegate <NSObject>

- (void)onboardingWillTransitionToIndex:(NSInteger)index;
- (void)onboardingWillTransitionToLeaving;
- (void)onboardingDidTransitionToIndex:(NSInteger)index;
// TODO: Delegate method for configuring Onboarding Content View
- (BOOL)enableTapsOnPageControl;

@end

@interface SLLPaperOnboarding : UIView



@end

NS_ASSUME_NONNULL_END
