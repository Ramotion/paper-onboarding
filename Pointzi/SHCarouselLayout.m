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
    PaperOnboarding *onboardingView = [[PaperOnboarding alloc]
                                       initWithItemsCount:tip.carousel.items.count];
    onboardingView.dataSource = self;
    onboardingView.delegate = self;
    onboardingView.translatesAutoresizingMaskIntoConstraints = NO;
    [viewContent addSubview:onboardingView];
    [viewContent sendSubviewToBack:onboardingView];
    //use constraints to add the paper onboarding view
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:onboardingView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:viewContent
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:tip.carousel.margin.left];
    [viewContent addConstraint:leading];
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:onboardingView
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:viewContent
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:tip.carousel.margin.right];
    [viewContent addConstraint:trailing];
    NSLayoutConstraint *top =[NSLayoutConstraint
                              constraintWithItem:onboardingView
                              attribute:NSLayoutAttributeTop
                              relatedBy:NSLayoutRelationEqual
                              toItem:viewContent
                              attribute:NSLayoutAttributeTop
                              multiplier:1.0f
                              constant:tip.carousel.margin.top];
    [viewContent addConstraint:top];
    NSLayoutConstraint *bottom =[NSLayoutConstraint
                                 constraintWithItem:onboardingView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:viewContent
                                 attribute:NSLayoutAttributeBottom
                                 multiplier:1.0f
                                 constant:tip.carousel.margin.bottom];
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
    item.shImageName = tipItem.image;
    item.shTitle = tipItem.titleText;
    item.shDesc = tipItem.contentText;
    item.shIconName = tipItem.icon;
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
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [StreetHawk notifyFeedResult:self.tipElement.feed_id
                          withResult:SHResult_Accept
                          withStepId:nil
                          deleteFeed:NO
                           completed:NO];
    });
}

- (void)onboardingConfigurationItem:(OnboardingContentViewItem * _Nonnull)item index:(NSInteger)index
{
}

@end
