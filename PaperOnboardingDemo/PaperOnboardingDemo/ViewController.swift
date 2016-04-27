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
      (UIImage.Asset.Hotels.rawValue, "Discover", "Etiam eleifend, risus a porta sagittis, quam turpis aliquet turpis."),
      (UIImage.Asset.Banks.rawValue, "Buy", "Etiam eleifend, risus a porta sagittis, quam turpis aliquet turpis."),
      (UIImage.Asset.Stores.rawValue, "Enjoy", "Etiam eleifend, risus a porta sagittis, quam turpis aliquet turpis.")
    ][index]
  }
  
  func onboardingBackgroundColorItemAtIndex(index: Int) -> UIColor {
    return [
      UIColor(red:0.41, green:0.56, blue:0.70, alpha:1.00),
      UIColor(red:0.41, green:0.69, blue:0.70, alpha:1.00),
      UIColor(red:0.31, green:0.31, blue:0.47, alpha:1.00)][index]
  }
  
  func pageViewIconAtIndex(index: Int) -> UIImage? {
    let imageNames = [UIImage.Asset.Key, UIImage.Asset.Wallet, UIImage.Asset.Shopping_Cart]
    return UIImage(asset: imageNames[index])
  }
}