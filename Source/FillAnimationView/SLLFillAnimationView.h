//
//  SLLFillAnimationView.h
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-14.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const kSLLPathConstant = @"path";
static NSString * const kSLLCircleConstant = @"circle";

@interface SLLFillAnimationView : UIView

+ (nullable SLLFillAnimationView *)animationOnView:(nonnull UIView *)view
                                             color:(nonnull UIColor *)color;
- (void)fillAnimationWithColor:(nonnull UIColor *)color
                centerPosition:(CGPoint)centerPosition
                      duration:(double)duration;

@end

NS_ASSUME_NONNULL_END
