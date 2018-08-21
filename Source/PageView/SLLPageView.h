//
//  SLLPageView.h
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-16.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLLPageContainer.h"
#import "SLLPageViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SLLPageView : UIView

@property (nonatomic, readwrite, assign) NSInteger itemsCount;
@property (nonatomic, readwrite, assign) CGFloat itemRadius;
@property (nonatomic, readwrite, assign) CGFloat selectedItemRadius;
@property (nonatomic, readwrite, assign) double duration;
@property (nonatomic, readwrite, assign) CGFloat space;
@property (nonatomic, readwrite, nullable, copy) UIColor * (^itemColor)(NSInteger index);
@property (nonatomic, readwrite, nullable, strong) SLLPageContainer *containerView;
@property (nonatomic, readwrite, nullable, copy) void (^configuration)(SLLPageViewItem *_Nullable item,
                                                                       NSInteger index);


- (nullable instancetype)initWithFrame:(CGRect)frame
                            itemsCount:(NSInteger)itemsCount
                                radius:(CGFloat)radius
                        selectedRadius:(CGFloat)selectedRadius
                             itemColor:(UIColor *(^_Nullable)(NSInteger index))itemColor;
+ (nullable SLLPageView *)pageViewOnView:(nonnull UIView *)view
                              itemsCount:(NSInteger)itemsCount
                          bottomConstant:(CGFloat)bottomConstant
                                  radius:(CGFloat)radius
                          selectedRadius:(CGFloat)selectedRadius
                               itemColor:(UIColor * (^_Nullable)(NSInteger index))itemColor;

- (void)setCurrentIndexToIndex:(NSInteger)index
                      animated:(BOOL)animated;
- (CGPoint)positionItemIndex:(NSInteger)index
                      onView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
