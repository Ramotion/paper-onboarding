//
//  ViewController.swift
//  AnimatedPageView
//
//  Created by Alex K. on 12/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var onboarding: PaperOnboarding!
  @IBOutlet weak var skipButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    skipButton.isHidden = true
    
    // Uncomment next line to setup `PaperOnboarding` from code
    // setupPaperOnboardingView()
  }
  
  private func setupPaperOnboardingView() {
    let onboarding = PaperOnboarding(itemsCount: 3)
    onboarding.dataSource = self
    onboarding.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(onboarding)
    
    // Add constraints
    for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
      let constraint = NSLayoutConstraint(item: onboarding,
                                          attribute: attribute,
                                          relatedBy: .equal,
                                          toItem: view,
                                          attribute: attribute,
                                          multiplier: 1,
                                          constant: 0)
      view.addConstraint(constraint)
    }
  }

}

// MARK: Actions
extension ViewController {
  
  @IBAction func skipButtonTapped(_ sender: UIButton) {
    print(#function)
  }
  
}

// MARK: PaperOnboardingDelegate
extension ViewController: PaperOnboardingDelegate {
    
  func onboardingWillTransitonToIndex(_ index: Int) {
    skipButton.isHidden = index == 2 ? false : true
  }
  
  func onboardingDidTransitonToIndex(_ index: Int) {
    
  }
  
  func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
    
//    item.titleLabel?.backgroundColor = .redColor()
//    item.descriptionLabel?.backgroundColor = .redColor()
//    item.imageView = ...
  }
  
}

// MARK: PaperOnboardingDataSource
extension ViewController: PaperOnboardingDataSource {
  
  func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
    let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    return [
      (Asset.hotels.image,
       "Hotels",
       "All hotels and hostels are sorted by hospitality rating",
       Asset.key.image,
       UIColor(red:0.40, green:0.56, blue:0.71, alpha:1.00),
       UIColor.white, UIColor.white, titleFont,descriptionFont),
        
      (Asset.banks.image,
       "Banks",
       "We carefully verify all banks before add them into the app",
       Asset.wallet.image,
       UIColor(red:0.40, green:0.69, blue:0.71, alpha:1.00),
       UIColor.white, UIColor.white, titleFont,descriptionFont),
      
      (Asset.stores.image,
       "Stores",
       "All local stores are categorized for your convenience",
       Asset.shoppingCart.image,
       UIColor(red:0.61, green:0.56, blue:0.74, alpha:1.00),
       UIColor.white, UIColor.white, titleFont,descriptionFont)
      
    ][index]
  }
  
  func onboardingItemsCount() -> Int {
    return 3
  }
  
}
