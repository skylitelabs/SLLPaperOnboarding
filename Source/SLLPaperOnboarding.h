//
//  SLLPaperOnboarding.h
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-13.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLLOnboardingItemInfo.h"
#import "SLLOnboardingContentView.h"

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
- (void)onboardingConfigurationItem:(SLLOnboardingContentViewItem *)item
                              index:(NSInteger)index;
- (BOOL)enableTapsOnPageControl;

@end

@interface SLLPaperOnboarding : UIView

@property (nonatomic, readwrite, nullable, weak) id<SLLPaperOnboardingDataSource> dataSource;
@property (nonatomic, readwrite, nullable, weak) id<SLLPaperOnboardingDelegate> delegate;

- (nullable instancetype)initWithPageViewBottomConstant:(CGFloat)pageViewBottomConstant;
- (void)setCurrentIndexToIndex:(NSInteger)index
                      animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
