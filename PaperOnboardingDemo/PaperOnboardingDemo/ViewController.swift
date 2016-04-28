//
//  ViewController.swift
//  AnimatedPageView
//
//  Created by Alex K. on 12/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // EXAMPLE USE FROM CODE
    
//    let onboarding = PaperOnboarding(itemsCount: 3, dataSource: self)
//    onboarding.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(onboarding)
//    
//    // add constratins 
//    for attribute: NSLayoutAttribute in [.Left, .Right, .Top, .Bottom] {
//      let constraint = NSLayoutConstraint(item: onboarding,
//                                          attribute: attribute,
//                                          relatedBy: .Equal,
//                                          toItem: view,
//                                          attribute: attribute,
//                                          multiplier: 1,
//                                          constant: 0)
//      view.addConstraint(constraint)
//    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func buttnoHandler(sender: AnyObject) {
  }
}

// MARK: PaperOnboardingDataSource

extension ViewController: PaperOnboardingDataSource {
  
  func onboardingItemAtIndex(index: Int) -> OnboardingItemInfo {
    return [
      (UIImage.Asset.Hotels.rawValue, "Hotels", "All hotels and hostels are sorted by hospitality rating"),
      (UIImage.Asset.Banks.rawValue, "Banks", "We carefully verify all banks before add them into the app"),
      (UIImage.Asset.Stores.rawValue, "Stores", "All local stores are categorized for your convenience")
    ][index]
  }
  
  func onboardingBackgroundColorItemAtIndex(index: Int) -> UIColor {
    return [
      UIColor(red:0.40, green:0.56, blue:0.71, alpha:1.00),
      UIColor(red:0.40, green:0.69, blue:0.71, alpha:1.00),
      UIColor(red:0.61, green:0.56, blue:0.74, alpha:1.00)][index]
  }
  
  func pageViewIconAtIndex(index: Int) -> UIImage? {
    let imageNames = [UIImage.Asset.Key, UIImage.Asset.Wallet, UIImage.Asset.Shopping_Cart]
    return UIImage(asset: imageNames[index])
  }
}