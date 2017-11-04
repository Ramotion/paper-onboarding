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

#import "SHCarouselBridge.h"
#import "SHCarouselLayout.h"

@interface SHCarouselBridge ()

//for layout carousel in the given view.
//notification name: SH_CarouselBridge_LayoutCarousel; user info: @{@"view": view_content, @"tip": tip}].
+ (void)layoutCarouselHandler:(NSNotification *)notification;

@end

@implementation SHCarouselBridge

+ (void)bridgeHandler:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(layoutCarouselHandler:) name:@"SH_CarouselBridge_LayoutCarousel" object:nil];
}

#pragma mark - private functions

+ (void)layoutCarouselHandler:(NSNotification *)notification
{
    UIView *viewContent = notification.userInfo[@"view"]; //tip controller's content view
    SHTipElement *tip = notification.userInfo[@"tip"];
    [[SHCarouselLayout sharedInstance] layoutCarouselOnView:viewContent
                                                     forTip:tip];
}

@end
