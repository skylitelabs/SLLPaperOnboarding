//
//  ViewController.m
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-13.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import "SLLViewController.h"

@interface SLLViewController () <SLLPaperOnboardingDelegate, SLLPaperOnboardingDataSource>

@property (nonatomic, readwrite, nullable, copy) NSArray<SLLOnboardingItemInfo *> *items;
@property (nonatomic, readwrite, nullable, copy) UIFont *titleFont;
@property (nonatomic, readwrite, nullable, copy) UIFont *descriptionFont;

@end

@implementation SLLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleFont = [UIFont fontWithName:@"AvenirNext-Bold" size:36.f];
    self.descriptionFont = [UIFont fontWithName:@"AvenirNext-Regular" size:14.f];
    
    UIImage *hotelsImage = [UIImage imageNamed:@"Hotels"];
    UIImage *banksImage = [UIImage imageNamed:@"Banks"];
    UIImage *storesImage = [UIImage imageNamed:@"Stores"];
    NSString *hotelStr = @"All hotels and hostels are sorted by hospitality rating.";
    NSString *banksStr = @"We carefully verify all banks before adding them into the app.";
    NSString *storesStr = @"All local stores are categorized for your convenience.";
    UIImage *hotelsIco = [UIImage imageNamed:@"Key"];
    UIImage *banksIco = [UIImage imageNamed:@"Wallet"];
    UIImage *storesIco = [UIImage imageNamed:@"Shopping-cart"];
    UIColor *hotelsCol = [UIColor colorWithRed:0.4f
                                         green:0.56f
                                          blue:0.71f
                                         alpha:1.f];
    UIColor *banksCol = [UIColor colorWithRed:0.4f
                                        green:0.69f
                                         blue:0.71f
                                        alpha:1.f];
    UIColor *storesCol = [UIColor colorWithRed:0.61f
                                         green:0.56f
                                          blue:0.74f
                                         alpha:1.f];
    
    SLLOnboardingItemInfo *item1 = [[SLLOnboardingItemInfo alloc] initWithInformationImage:hotelsImage
                                                                                     title:@"Hotels"
                                                                               description:hotelStr
                                                                                  pageIcon:hotelsIco
                                                                                     color:hotelsCol
                                                                                titleColor:[UIColor whiteColor]
                                                                          descriptionColor:[UIColor whiteColor]
                                                                                 titleFont:self.titleFont
                                                                           descriptionFont:self.descriptionFont];
    SLLOnboardingItemInfo *item2 = [[SLLOnboardingItemInfo alloc] initWithInformationImage:banksImage
                                                                                     title:@"Banks"
                                                                               description:banksStr
                                                                                  pageIcon:banksIco
                                                                                     color:banksCol
                                                                                titleColor:[UIColor whiteColor]
                                                                          descriptionColor:[UIColor whiteColor]
                                                                                 titleFont:self.titleFont
                                                                           descriptionFont:self.descriptionFont];
    SLLOnboardingItemInfo *item3 = [[SLLOnboardingItemInfo alloc] initWithInformationImage:storesImage
                                                                                     title:@"Stores"
                                                                               description:storesStr
                                                                                  pageIcon:storesIco
                                                                                     color:storesCol
                                                                                titleColor:[UIColor whiteColor]
                                                                          descriptionColor:[UIColor whiteColor]
                                                                                 titleFont:self.titleFont
                                                                           descriptionFont:self.descriptionFont];
    self.items = @[item1, item2, item3];
                                    
    self.skipButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.skipButton setTitle:@"Skip"
                     forState:UIControlStateNormal];
    [self.skipButton setTitleColor:[UIColor blackColor]
                          forState:UIControlStateNormal];
    self.skipButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular"
                                                      size:24];
    self.skipButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.skipButton.hidden = NO;
    [self setupPaperOnboardingView];
    [self.view addSubview:self.skipButton];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.skipButton
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.f
                                                           constant:-20.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.skipButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.f
                                                           constant:40.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.skipButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.f
                                                           constant:70.f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.skipButton
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.f
                                                           constant:45.f]];
}

- (void)setupPaperOnboardingView {
    SLLPaperOnboarding *onboarding = [[SLLPaperOnboarding alloc] initWithPageViewBottomConstant:32];
    onboarding.delegate = self;
    onboarding.dataSource = self;
    onboarding.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:onboarding];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:onboarding
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.f
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:onboarding
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.f
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:onboarding
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.f
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:onboarding
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.f
                                                           constant:0]];
}

#pragma mark - Paper Onboarding Delegate

- (void)onboardingWillTransitionToIndex:(NSInteger)index {
//    self.skipButton.hidden = !(index == 2);
}

- (void)onboardingDidTransitionToIndex:(NSInteger)index {
    
}

- (void)onboardingConfigurationItem:(SLLOnboardingContentViewItem *)item
                              index:(NSInteger)index {
    
}

#pragma mark - Paper Onboarding Data Source

- (SLLOnboardingItemInfo *)onboardingItemAtIndex:(NSInteger)index {
    return self.items[index];
}

- (NSInteger)onboardingItemsCount {
    return 3;
}

@end
