/*
 * Copyright (c) StreetHawk, All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3.0 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.
 */

#import "SHCarouselLayout.h"
//header from StreetHawk
#import <StreetHawkCore/StreetHawkCore.h>
//header from PaperOnboarding
#import <PaperOnboarding/PaperOnboarding-Swift.h>

@interface SHCarouselLayout () <PaperOnboardingDataSource, PaperOnboardingDelegate>

@property (nonatomic, strong) SHTipElement *tipElement;

@end

@implementation SHCarouselLayout

+ (SHCarouselLayout *)sharedInstance
{
    static SHCarouselLayout *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SHCarouselLayout alloc] init];
    });
    return sharedInstance;
}

- (void)layoutCarouselOnView:(UIView *)viewContent forTip:(SHTipElement *)tip
{
    if (viewContent == nil
        || tip == nil
        || tip.carousel.items.count == 0)
    {
        return; //not have any carousel to show
    }
    self.tipElement = tip;
    UIView *viewCarousel = [[UIView alloc] init];
    [viewContent addSubview:viewCarousel];
    //must have this otherwise constraints cannot work
    viewCarousel.translatesAutoresizingMaskIntoConstraints = NO;
    [viewContent sendSubviewToBack:viewCarousel];
    viewContent.layer.borderColor = tip.carousel.borderColor.CGColor;
    viewContent.layer.borderWidth = tip.carousel.borderWidth;
    viewContent.layer.cornerRadius = tip.carousel.cornerRadius;
    PaperOnboarding *viewOnboarding = [[PaperOnboarding alloc] initWithItemsCount:tip.carousel.items.count];
    viewOnboarding.dataSource = self;
    viewOnboarding.delegate = self;
    viewOnboarding.translatesAutoresizingMaskIntoConstraints = NO;
    [viewCarousel addSubview:viewOnboarding];
    viewOnboarding.layer.borderWidth = 0;
    viewOnboarding.layer.cornerRadius = tip.carousel.cornerRadius;
    viewOnboarding.clipsToBounds = YES; //limit content even with shadow
    if (tip.carousel.boxShadow == 0) //no shadow
    {
        //clipsToBounds and masksToBound not co-work well.
        //when masksToBound=NO it doesn't show shadow,
        //however when masksToBound=YES the subviews go out of bound.
        viewCarousel.clipsToBounds = YES;
    }
    else
    {
        viewCarousel.layer.shadowOffset = CGSizeMake(tip.carousel.boxShadow, tip.carousel.boxShadow);
        viewCarousel.layer.shadowOpacity = 0.5f;
        viewCarousel.layer.shadowRadius = tip.carousel.cornerRadius;
    }
    //use constraints to add the paper onboarding view
    NSLayoutConstraint *leadingInner = [NSLayoutConstraint
                                        constraintWithItem:viewOnboarding
                                        attribute:NSLayoutAttributeLeading
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:viewCarousel
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1.0f
                                        constant:0];
    [viewCarousel addConstraint:leadingInner];
    NSLayoutConstraint *trailingInner =[NSLayoutConstraint
                                        constraintWithItem:viewOnboarding
                                        attribute:NSLayoutAttributeTrailing
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:viewCarousel
                                        attribute:NSLayoutAttributeTrailing
                                        multiplier:1.0f
                                        constant:0];
    [viewCarousel addConstraint:trailingInner];
    NSLayoutConstraint *topInner =[NSLayoutConstraint
                                   constraintWithItem:viewOnboarding
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:viewCarousel
                                   attribute:NSLayoutAttributeTop
                                   multiplier:1.0f
                                   constant:0];
    [viewCarousel addConstraint:topInner];
    NSLayoutConstraint *bottomInner =[NSLayoutConstraint
                                      constraintWithItem:viewOnboarding
                                      attribute:NSLayoutAttributeBottom
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:viewCarousel
                                      attribute:NSLayoutAttributeBottom
                                      multiplier:1.0f
                                      constant:0];
    [viewCarousel addConstraint:bottomInner];
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:viewCarousel
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:viewContent
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:tip.carousel.margin.left];
    [viewContent addConstraint:leading];
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:viewCarousel
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:viewContent
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:-tip.carousel.margin.right];
    [viewContent addConstraint:trailing];
    NSLayoutConstraint *top =[NSLayoutConstraint
                              constraintWithItem:viewCarousel
                              attribute:NSLayoutAttributeTop
                              relatedBy:NSLayoutRelationEqual
                              toItem:viewContent
                              attribute:NSLayoutAttributeTop
                              multiplier:1.0f
                              constant:tip.carousel.margin.top];
    [viewContent addConstraint:top];
    NSLayoutConstraint *bottom =[NSLayoutConstraint
                                 constraintWithItem:viewCarousel
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:viewContent
                                 attribute:NSLayoutAttributeBottom
                                 multiplier:1.0f
                                 constant:-tip.carousel.margin.bottom];
    [viewContent addConstraint:bottom];
}

#pragma mark - delegate and datasource

- (NSInteger)onboardingItemsCount SWIFT_WARN_UNUSED_RESULT
{
    return self.tipElement.carousel.items.count;
}

- (OnboardingItemInfo * _Nonnull)onboardingItemAtIndex:(NSInteger)index SWIFT_WARN_UNUSED_RESULT
{
    OnboardingItemInfo *item = [OnboardingItemInfo new];
    SHTipCarouselItem *tipItem = self.tipElement.carousel.items[index];
    item.shImage = tipItem.image;
    item.shImageSource = tipItem.imageSource;
    item.shTitle = tipItem.titleText;
    item.shDesc = tipItem.contentText;
    item.shIcon = tipItem.icon;
    item.shIconSource = tipItem.iconSource;
    item.shColor = tipItem.backgroundColor;
    item.shTitleColor = tipItem.titleColor;
    item.shDescriptionColor = tipItem.contentColor;
    item.shTitleFont = tipItem.titleFont;
    item.shDescriptionFont = tipItem.contentFont;
    return item;
}

- (void)onboardingWillTransitonToIndex:(NSInteger)index
{
}

- (void)onboardingDidTransitonToIndex:(NSInteger)index
{
}

- (void)onboardingConfigurationItem:(OnboardingContentViewItem * _Nonnull)item index:(NSInteger)index
{
}

@end
