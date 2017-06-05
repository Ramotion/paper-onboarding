//
//  PaperOnboardingDelegate.swift
//  PaperOnboardingDemo
//
//  Created by Abdurahim Jauzee on 05/06/2017.
//  Copyright © 2017 Alex K. All rights reserved.
//

import Foundation


/**
 *  The delegate of a PaperOnboarding object must adopt the PaperOnboardingDelegate protocol. Optional methods of the
 protocol allow the delegate to manage items, configure items, and perform other actions.
 */
public protocol PaperOnboardingDelegate {
  
  /**
   Tells the delegate that the paperOnbording start scrolling.
   
   - parameter index: An curretn index item
   */
  func onboardingWillTransitonToIndex(_ index: Int)
  
  /**
   Tells the delegate that the specified item is now selected
   
   - parameter index: An curretn index item
   */
  func onboardingDidTransitonToIndex(_ index: Int)
  
  /**
   Tells the delegate the PaperOnboarding is about to draw a item for a particular row. Use this method for configure items
   
   - parameter item:  A OnboardingContentViewItem object that PaperOnboarding is going to use when drawing the row.
   - parameter index: An curretn index item
   */
  func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int)
  
  /**
   Should `PaperOnboarding` react to taps on `PageControl` view.
   If `true`, will scroll to tapped page.
   */
  var enableTapsOnPageControl: Bool { get }
  
}

// This extension will make the delegate method optional
public extension PaperOnboardingDelegate {
  func onboardingWillTransitonToIndex(_ index: Int) { }
  func onboardingDidTransitonToIndex(_ index: Int) { }
  func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) { }
  var enableTapsOnPageControl: Bool { return true }
}
