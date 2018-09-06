//
//  SLLOnboardingItemInfo.m
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-13.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import "SLLOnboardingItemInfo.h"

@implementation SLLOnboardingItemInfo

- (instancetype)initWithInformationImage:(UIImage *)informationImage
                                   title:(NSString *)title
                             description:(NSString *)description
                                pageIcon:(UIImage *)pageIcon
                                   color:(UIColor *)color
                              titleColor:(UIColor *)titleColor
                        descriptionColor:(UIColor *)descriptionColor
                               titleFont:(UIFont *)titleFont
                         descriptionFont:(UIFont *)descriptionFont {
    if (self = [super init]) {
        self.informationImage = informationImage;
        self.title = title;
        self.desc = description;
        self.pageIcon = pageIcon;
        self.color = color;
        self.titleColor = titleColor;
        self.descriptionColor = descriptionColor;
        self.titleFont = titleFont;
        self.descriptionFont = descriptionFont;
    }
    return self;
}

@end
