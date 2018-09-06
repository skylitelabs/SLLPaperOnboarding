//
//  SLLGestureControl.h
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-20.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SLLGestureControl;

@protocol SLLGestureControlDelegate <NSObject>

- (void)gestureControlDidSwipeWithDirection:(UISwipeGestureRecognizerDirection)direction;

@end

@interface SLLGestureControl : UIView

@property (nonatomic, readwrite, nullable, weak) id<SLLGestureControlDelegate> delegate;

- (nullable instancetype)initWithView:(nonnull UIView *)view
                             delegate:(nullable id<SLLGestureControlDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
