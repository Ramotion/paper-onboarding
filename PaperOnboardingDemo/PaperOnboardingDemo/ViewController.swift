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

// MARK: OnboardingDataSource

extension ViewController: OnboardingDataSource {
  
  func onboardingItemAtIndex(index: Int) -> OnboardingItemInfo {
    return [
      ("bigIcon0", "Discover", "Etiam eleifend, risus a porta sagittis, quam turpis aliquet turpis."),
      ("bigIcon1", "Buy", "Etiam eleifend, risus a porta sagittis, quam turpis aliquet turpis."),
      ("bigIcon2", "Enjoy", "Etiam eleifend, risus a porta sagittis, quam turpis aliquet turpis.")
    ][index]
  }
  
  func onboardingBackgroundColorItemAtIndex(index: Int) -> UIColor {
    return [
      UIColor(red:0.41, green:0.56, blue:0.70, alpha:1.00),
      UIColor(red:0.41, green:0.69, blue:0.70, alpha:1.00),
      UIColor(red:0.31, green:0.31, blue:0.47, alpha:1.00)][index]
  }
  
  func pageViewIconAtIndex(index: Int) -> UIImage? {
    return UIImage(named: "icon\(index)")
  }
}