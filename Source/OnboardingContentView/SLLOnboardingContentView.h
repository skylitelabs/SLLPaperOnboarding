//
//  SLLOnboardingContentView.h
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-14.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLLOnboardingItemInfo.h"
#import "SLLOnboardingContentViewItem.h"

NS_ASSUME_NONNULL_BEGIN

static const CGFloat kSLLDyOffsetAnimation = 110;
static const double kSLLShowDuration = 0.8;
static const double kSLLHideDuration = 0.2;

@class SLLOnboardingContentView;
@class SLLOnboardingItemInfo;
@class SLLOnboardingContentViewItem;

@protocol SLLOnboardingContentViewDelegate <NSObject>

- (nullable SLLOnboardingItemInfo *)onboardingItemAtIndex:(NSInteger)index;
- (void)onboardingConfigurationItem:(nonnull SLLOnboardingContentViewItem *)item
                            atIndex:(NSInteger)index;

@end

@interface SLLOnboardingContentView : UIView

@property (nonatomic, readwrite, nullable, weak) id<SLLOnboardingContentViewDelegate> delegate;

- (nullable instancetype)initWithItemsCount:(NSInteger)itemsCount
                                   delegate:(nullable id<SLLOnboardingContentViewDelegate>)delegate;
- (void)setCurrentItemToIndex:(NSInteger)index
                     animated:(BOOL)animated;
+ (nullable SLLOnboardingContentView *)contentViewOnView:(nonnull UIView *)view
                                                delegate:(nullable id<SLLOnboardingContentViewDelegate>)delegate
                                              itemsCount:(NSInteger)itemsCount
                                          bottomConstant:(CGFloat)bottomConstant;


@end

NS_ASSUME_NONNULL_END
