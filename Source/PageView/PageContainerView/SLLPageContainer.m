//
//  SLLPageContainer.m
//  SLLPaperOnboardingDemo
//
//  Created by Leejay Schmidt on 2018-08-15.
//  Copyright © 2018 Skylite Labs. All rights reserved.
//

#import "SLLPageContainer.h"

@interface SLLPageContainer ()

@property (nonatomic, readwrite, assign) CGFloat itemRadius;
@property (nonatomic, readwrite, assign) CGFloat selectedItemRadius;
@property (nonatomic, readwrite, assign) NSInteger itemsCount;
@property (nonatomic, readwrite, nonnull, copy) NSString *animationKey;

@end

@implementation SLLPageContainer

- (instancetype)initWithRadius:(CGFloat)radius
                selectedRadius:(CGFloat)selectedRadius
                         space:(CGFloat)space
                    itemsCount:(NSInteger)itemsCount
                     itemColor:(UIColor * (^_Nullable)(NSInteger index))itemColor {
    if (self = [super initWithFrame:CGRectZero]) {
        self.animationKey = @"animationKey";
        self.itemsCount = itemsCount;
        self.space = space;
        self.itemRadius = radius;
        self.selectedItemRadius = selectedRadius;
        self.items = [self createItemsWithCount:itemsCount
                                         radius:radius
                                 selectedRadius:selectedRadius
                                      itemColor:itemColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [NSException raise:@"InitNotImplemented" format:@"initWithCoder: has not been implemented"];
    return self;
}

- (void)setCurrentIndexToIndex:(NSInteger)index
                      duration:(double)duration
                      animated:(BOOL)animated {
    if (!(self.items && index != self.currentIndex)) {
        return;
    }
    
}

#pragma mark - Animations

- (void)animationItem:(SLLPageViewItem *)item
             selected:(BOOL)selected
             duration:(double)duration
            fillColor:(BOOL)fillColor {
    CGFloat toValue = selected ? (self.selectedItemRadius * 2.f) : (self.itemRadius * 2.f);
    NSPredicate *itemPredicate = [NSPredicate predicateWithFormat:@"identifier == 'animationKey'"];
    NSArray<NSLayoutConstraint *> *itemConstraints = [item.constraints filteredArrayUsingPredicate:itemPredicate];
    for (NSLayoutConstraint *constraint in itemConstraints) {
        constraint.constant = toValue;
    }
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self layoutIfNeeded];
                     }
                     completion:nil];
    [item animationSelected:selected
                   duration:duration
                  fillColor:fillColor];
}

#pragma mark - Creation

- (NSArray<SLLPageViewItem *> *)createItemsWithCount:(NSInteger)count
                                              radius:(CGFloat)radius
                                      selectedRadius:(CGFloat)selectedRadius
                                           itemColor:(UIColor * (^_Nullable)(NSInteger index))itemColor {
    if (count < 1) {
        [NSException raise:@"CountTooLow" format:@"The count must be greater than 0"];
    } else if (!itemColor) {
        [NSException raise:@"MissingParam" format:@"itemColor must be an initialized code block"];
    }
    NSMutableArray<SLLPageViewItem *> *items = [[NSMutableArray alloc] init];
    
    // create the first item
    NSInteger tag = 1;
    SLLPageViewItem *item = [self createItemWithRadius:radius
                                        selectedRadius:selectedRadius
                                            isSelected:YES
                                             itemColor:itemColor ? itemColor(tag - 1) : [UIColor whiteColor]];
    item.tag = tag;
    [self addConstraintsToView:item radius:selectedRadius];
    [items addObject:item];
    
    for (NSInteger i = 1; i < count; ++i) {
        tag += 1;
        SLLPageViewItem *nextItem = [self createItemWithRadius:radius
                                                selectedRadius:selectedRadius
                                                    isSelected:NO
                                                     itemColor:itemColor ? itemColor(tag - 1) : [UIColor whiteColor]];
        [self addConstraintsToView:nextItem
                          leftItem:item
                            radius:radius];
        [items addObject:nextItem];
        item = nextItem;
        item.tag = tag;
    }
    
    return items;
}


- (SLLPageViewItem *)createItemWithRadius:(CGFloat)radius
                           selectedRadius:(CGFloat)selectedRadius
                               isSelected:(BOOL)isSelected
                                itemColor:(UIColor *)itemColor {
    SLLPageViewItem *item = [[SLLPageViewItem alloc] initWithRadius:radius
                                                          itemColor:itemColor
                                                     selectedRadius:selectedRadius
                                                          lineWidth:3.f
                                                           isSelect:isSelected];
    item.translatesAutoresizingMaskIntoConstraints = NO;
    item.backgroundColor = [UIColor clearColor];
    
    [self addSubview:item];
    return item;
}

- (void)addConstraintsToView:(UIView *)view
                      radius:(CGFloat)radius {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.f
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.f
                                                      constant:0]];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:0.f
                                                                        constant:(radius * 2.f)];
    widthConstraint.identifier = self.animationKey;
    [self addConstraint:widthConstraint];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:0.f
                                                                         constant:(radius * 2.f)];
    widthConstraint.identifier = self.animationKey;
    [self addConstraint:heightConstraint];
}

- (void)addConstraintsToView:(UIView *)view
                    leftItem:(UIView *)leftItem
                      radius:(CGFloat)radius {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.f
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:leftItem
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.f
                                                      constant:self.space]];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:0.f
                                                                        constant:(radius * 2.f)];
    widthConstraint.identifier = self.animationKey;
    [self addConstraint:widthConstraint];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:0.f
                                                                         constant:(radius * 2.f)];
    heightConstraint.identifier = self.animationKey;
    [self addConstraint:heightConstraint];
}

@end
