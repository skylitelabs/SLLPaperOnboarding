//
//  SLLPageViewItem.h
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-15.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLLPageViewItem : UIView

@property (nonatomic, readwrite, assign) CGFloat circleRadius;
@property (nonatomic, readwrite, assign) CGFloat selectedCircleRadius;
@property (nonatomic, readwrite, assign) CGFloat lineWidth;
@property (nonatomic, readwrite, nullable, strong) UIColor *itemColor;

@property (nonatomic, readwrite, assign) BOOL select;

@property (nonatomic, readwrite, nullable, strong) UIView *centerView;
@property (nonatomic, readwrite, nullable, strong) UIImageView *imageView;
@property (nonatomic, readwrite, nullable, strong) CAShapeLayer *circleLayer;
@property (nonatomic, readwrite, assign) NSInteger tickIndex;

- (nullable instancetype)initWithRadius:(CGFloat)radius
                              itemColor:(nonnull UIColor *)itemColor
                         selectedRadius:(CGFloat)selectedRadius
                              lineWidth:(CGFloat)lineWidth
                               isSelect:(BOOL)isSelect;
- (void)animationSelected:(BOOL)selected
                 duration:(double)duration
                fillColor:(BOOL)fillColor;

@end

NS_ASSUME_NONNULL_END
