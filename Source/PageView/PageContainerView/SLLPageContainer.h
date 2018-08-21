//
//  SLLPageContainer.h
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-15.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLLPageViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface SLLPageContainer : UIView

@property (nonatomic, readwrite, nullable, copy) NSArray<SLLPageViewItem *> *items;
@property (nonatomic, readwrite, assign) CGFloat space;
@property (nonatomic, readwrite, assign) NSInteger currentIndex;

- (nullable instancetype)initWithRadius:(CGFloat)radius
                         selectedRadius:(CGFloat)selectedRadius
                                  space:(CGFloat)space
                             itemsCount:(NSInteger)itemsCount
                              itemColor:(UIColor * (^_Nullable)(NSInteger index))itemColor;
- (void)setCurrentIndexToIndex:(NSInteger)index
                      duration:(double)duration
                      animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
