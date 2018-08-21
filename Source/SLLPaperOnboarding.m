//
//  SLLPaperOnboarding.m
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-13.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import "SLLPaperOnboarding.h"
// supporting classes
#import "SLLGestureControl.h"
#import "SLLFillAnimationView.h"
#import "SLLPageView.h"

@interface SLLPaperOnboarding () <SLLGestureControlDelegate, SLLOnboardingContentViewDelegate>

@property (nonatomic, readwrite, assign) NSInteger currentIndex;
@property (nonatomic, readwrite, assign) NSInteger itemsCount;
@property (nonatomic, readwrite, nullable, copy) NSArray<SLLOnboardingItemInfo *> *itemsInfo;

@property (nonatomic, readwrite, assign) CGFloat pageViewBottomConstant;
@property (nonatomic, readwrite, assign) CGFloat pageViewSelectedRadius;
@property (nonatomic, readwrite, assign) CGFloat pageViewRadius;

@property (nonatomic, readwrite, nullable, strong) SLLFillAnimationView *fillAnimationView;
@property (nonatomic, readwrite, nullable, strong) SLLPageView *pageView;
@property (nonatomic, readwrite, nullable, strong) SLLGestureControl *gestureControl;
@property (nonatomic, readwrite, nullable, strong) SLLOnboardingContentView *contentView;

@end

@implementation SLLPaperOnboarding

- (void)setDataSource:(id<SLLPaperOnboardingDataSource>)dataSource {
    _dataSource = dataSource;
    [self commonInit];
}

#pragma mark - Initialization

- (instancetype)initWithPageViewBottomConstant:(CGFloat)pageViewBottomConstant {
    if (self = [super initWithFrame:CGRectZero]) {
        self.pageViewBottomConstant = pageViewBottomConstant;
        self.pageViewSelectedRadius = 22.f;
        self.pageViewRadius = 8.f;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.pageViewBottomConstant = 32.f;
        self.pageViewSelectedRadius = 22.f;
        self.pageViewRadius = 8.f;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.pageViewRadius = 8.f;
        self.pageViewSelectedRadius = 22.f;
        self.pageViewBottomConstant = 32.f;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.pageViewBottomConstant = 32.f;
        self.pageViewSelectedRadius = 22.f;
        self.pageViewRadius = 8.f;
    }
    return self;
}

#pragma mark - Methods

- (void)setCurrentIndexToIndex:(NSInteger)index
                      animated:(BOOL)animated {
    if ((index >= 0) && (index < self.itemsCount)) {
        if ([self.delegate respondsToSelector:@selector(onboardingWillTransitionToIndex:)]) {
            [self.delegate onboardingWillTransitionToIndex:index];
        }
        self.currentIndex = index;
        [CATransaction setCompletionBlock:^{
            if ([self.delegate respondsToSelector:@selector(onboardingDidTransitionToIndex:)]) {
                [self.delegate onboardingDidTransitionToIndex:index];
            }
        }];
        if (self.pageView) {
            CGPoint position = [self.pageView positionItemIndex:index onView:self];
            if ([self.fillAnimationView respondsToSelector:@selector(fillAnimationWithColor:
                                                                     centerPosition:
                                                                     duration:)]) {
                [self.fillAnimationView fillAnimationWithColor:[self backgroundColorAtIndex:index]
                                                centerPosition:position
                                                      duration:0.5];
            }
            [self.pageView setCurrentIndexToIndex:index animated:animated];
        }
        if (self.contentView) {
            [self.contentView setCurrentItemToIndex:index animated:animated];
        }
        [CATransaction commit];
    } else if (index >= self.itemsCount) {
        if ([self.delegate respondsToSelector:@selector(onboardingWillTransitionToLeaving)]) {
            [self.delegate onboardingWillTransitionToLeaving];
        }
    }
}

#pragma mark - Create

- (void)commonInit {
    if (self.dataSource) {
        self.itemsCount = [self.dataSource onboardingItemsCount];
        if ([self.dataSource respondsToSelector:@selector(onboardingPageItemRadius)]) {
            self.pageViewRadius = [self.dataSource onboardingPageItemRadius];
        } else {
            self.pageViewRadius = 8;
        }
        if ([self.dataSource respondsToSelector:@selector(onboardingPageItemSelectedRadius)]) {
            self.pageViewSelectedRadius = [self.dataSource onboardingPageItemSelectedRadius];
        } else {
            self.pageViewSelectedRadius = 22;
        }
    }
    self.itemsInfo = [self createItemsInfo];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.fillAnimationView = [SLLFillAnimationView animationOnView:self
                                                             color:[self backgroundColorAtIndex:self.currentIndex]];
    self.contentView = [SLLOnboardingContentView contentViewOnView:self
                                                          delegate:self
                                                        itemsCount:self.itemsCount
                                                    bottomConstant:(self.pageViewBottomConstant * -1) -
                                                                    self.pageViewSelectedRadius];
    self.pageView = [self createPageView];
    self.gestureControl = [[SLLGestureControl alloc] initWithView:self
                                                         delegate:self];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(enableTapsOnPageControl)] &&
        [self.delegate enableTapsOnPageControl] &&
        self.pageView &&
        self.pageView.containerView) {
        CGPoint touchLocation = [sender locationInView:self];
        CGPoint convertedLocation = [self.pageView.containerView convertPoint:touchLocation
                                                                     fromView:self];
        UIView *pageItem = [self.pageView hitTest:convertedLocation
                                        withEvent:nil];
        if (!pageItem) {
            return;
        }
        NSInteger index = pageItem.tag - 1;
        if (index == self.currentIndex) {
            return;
        }
        [self setCurrentIndexToIndex:index
                            animated:YES];
        if ([self.delegate respondsToSelector:@selector(onboardingWillTransitionToIndex:)]) {
            [self.delegate onboardingWillTransitionToIndex:index];
        }
    }
}

- (SLLPageView *)createPageView {
    __weak SLLPaperOnboarding *weakSelf = self;
    SLLPageView *pageView = [SLLPageView pageViewOnView:self
                                             itemsCount:self.itemsCount
                                         bottomConstant:self.pageViewBottomConstant * -1
                                                 radius:self.pageViewRadius
                                         selectedRadius:self.pageViewSelectedRadius
                                              itemColor:^UIColor * _Nonnull(NSInteger index) {
                                                  if ([weakSelf.dataSource respondsToSelector:@selector(onboardingPageItemColorAtIndex:)]) {
                                                      return [weakSelf.dataSource onboardingPageItemColorAtIndex:index];
                                                  } else {
                                                      return [UIColor whiteColor];
                                                  }
                                              }];
    pageView.configuration = ^void (SLLPageViewItem *_Nullable item, NSInteger index) {
        if (item.imageView) {
            item.imageView.image = self.itemsInfo ? self.itemsInfo[index].pageIcon : nil;
        }
    };
    return pageView;
}

- (NSArray<SLLOnboardingItemInfo *> *)createItemsInfo {
    if (!self.dataSource) {
        [NSException raise:@"NoDatasource" format:@"dataSource must be set. Please set dataSource"];
    }
    NSMutableArray<SLLOnboardingItemInfo *> *items = [[NSMutableArray alloc] init];
    for (NSInteger idx = 0; idx < self.itemsCount; ++idx) {
        SLLOnboardingItemInfo *info = [self.dataSource onboardingItemAtIndex:idx];
        [items addObject:info];
    }
    return items;
}

#pragma mark - Helpers

- (UIColor *)backgroundColorAtIndex:(NSInteger)index {
    UIColor *color;
    if (self.itemsInfo && self.itemsInfo[index]) {
        color = self.itemsInfo[index].color;
    }
    return color ? : [UIColor blackColor];
}

#pragma mark - Gesture Control Delegate

- (void)gestureControlDidSwipeWithDirection:(UISwipeGestureRecognizerDirection)direction {
    switch (direction) {
        case UISwipeGestureRecognizerDirectionRight:
            [self setCurrentIndexToIndex:self.currentIndex - 1
                                animated:YES];
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            [self setCurrentIndexToIndex:self.currentIndex + 1
                                animated:YES];
            break;
        default:
            [NSException raise:@"InvalidDirection"
                        format:@"Direction for Gesture Control must be either right or left"];
            break;
    }
}

#pragma mark - Onboarding Delegate

- (SLLOnboardingItemInfo *)onboardingItemAtIndex:(NSInteger)index {
    return self.itemsInfo ? self.itemsInfo[index] : nil;
}

- (void)onboardingConfigurationItem:(SLLOnboardingContentViewItem *)item atIndex:(NSInteger)index {
    if (self.delegate) {
        [self.delegate onboardingConfigurationItem:item index:index];
    }
}

@end
