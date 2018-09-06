//
//  SLLOnboardingContentViewItem.h
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-13.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLLOnboardingContentViewItem : UIView

@property (nonatomic, readwrite, nullable, strong) NSLayoutConstraint *descriptionBottomConstraint;
@property (nonatomic, readwrite, nullable, strong) NSLayoutConstraint *titleCenterConstraint;
@property (nonatomic, readwrite, nullable, strong) NSLayoutConstraint *informationImageWidthConstraint;
@property (nonatomic, readwrite, nullable, strong) NSLayoutConstraint *informationImageHeightConstraint;

@property (nonatomic, readwrite, nullable, strong) UIImageView *imageView;
@property (nonatomic, readwrite, nullable, strong) UILabel *titleLabel;
@property (nonatomic, readwrite, nullable, strong) UILabel *descriptionLabel;

+ (nullable SLLOnboardingContentViewItem *)itemOnView:(nonnull UIView *)view;

@end

NS_ASSUME_NONNULL_END
