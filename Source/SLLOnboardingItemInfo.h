//
//  SLLOnboardingItemInfo.h
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-13.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLLOnboardingItemInfo : NSObject

@property (nonatomic, readwrite, nullable, strong) UIImage *informationImage;
@property (nonatomic, readwrite, nullable, copy) NSString *title;
@property (nonatomic, readwrite, nullable, copy) NSString *desc;
@property (nonatomic, readwrite, nullable, strong) UIImage *pageIcon;
@property (nonatomic, readwrite, nullable, strong) UIColor *color;
@property (nonatomic, readwrite, nullable, strong) UIColor *titleColor;
@property (nonatomic, readwrite, nullable, strong) UIColor *descriptionColor;
@property (nonatomic, readwrite, nullable, strong) UIFont *titleFont;
@property (nonatomic, readwrite, nullable, strong) UIFont *descriptionFont;

- (nullable instancetype)initWithInformationImage:(nullable UIImage *)informationImage
                                            title:(nullable NSString *)title
                                      description:(nullable NSString *)description
                                         pageIcon:(nullable UIImage *)pageIcon
                                            color:(nullable UIColor *)color
                                       titleColor:(nullable UIColor *)titleColor
                                 descriptionColor:(nullable UIColor *)descriptionColor
                                        titleFont:(nullable UIFont *)titleFont
                                  descriptionFont:(nullable UIFont *)descriptionFont;

@end

NS_ASSUME_NONNULL_END
