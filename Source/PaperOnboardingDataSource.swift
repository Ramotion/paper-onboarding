//
//  PaperOnboardingDataSource.swift
//  PaperOnboardingDemo
//
//  Created by Abdurahim Jauzee on 05/06/2017.
//  Copyright © 2017 Alex K. All rights reserved.
//

import Foundation


/**
 *  The PaperOnboardingDataSource protocol is adopted by an object that mediates the application’s data model for a PaperOnboarding object.
 The data source information it needs to construct and modify a PaperOnboarding.
 */
public protocol PaperOnboardingDataSource {
  
  /**
   Asks the data source to return the number of items.
   
   - parameter index: An index of item in PaperOnboarding.
   - returns: The number of items in PaperOnboarding.
   */
  func onboardingItemsCount() -> Int
  
  /**
   Asks the data source for configureation item.
   
   - parameter index: An index of item in PaperOnboarding.
   - returns: configuration info for item
   */
  func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo
  
}
