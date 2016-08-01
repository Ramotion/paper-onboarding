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
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    
    skipButton.hidden = true
    
    // EXAMPLE USE FROM CODE
    
//    let onboarding = PaperOnboarding(itemsCount: 3)
//    onboarding.dataSource = self
//    onboarding.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(onboarding)
//    
//    // add constraints
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

// MARK: Actions

extension ViewController {
  
  @IBAction func buttonHandler(sender: AnyObject) {
    print("skip handler")
  }
}

extension ViewController: PaperOnboardingDelegate {
  
  func onboardingWillTransitonToIndex(index: Int) {
    skipButton.hidden = index == 2 ? false : true
  }
  
  func onboardingDidTransitonToIndex(index: Int) {
    
  }
  
  func onboardingConfigurationItem(item: OnboardingContentViewItem, index: Int) {
    
//    item.titleLabel?.backgroundColor = .redColor()
//    item.descriptionLabel?.backgroundColor = .redColor()
//    item.imageView = ...
  }
}

// MARK: PaperOnboardingDataSource

extension ViewController: PaperOnboardingDataSource {
  
  func onboardingItemAtIndex(index: Int) -> OnboardingItemInfo {
    let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFontOfSize(36.0)
    let descriptionFont = UIFont(name: "OpenSans-Regular", size: 17.0) ?? UIFont.systemFontOfSize(17.0)
    
    let items: [OnboardingItemInfo] = [
        OnboardingItemInfo(imageName: UIImage.Asset.Hotels.rawValue, title: "Hotels", description: "Get notified with cool new places around you, and check out live video streams from supported locations.", iconName: UIImage.Asset.Key.rawValue, color: UIColor(red:0.40, green:0.56, blue:0.71, alpha:1.00), titleFont: titleFont, descriptionFont: descriptionFont, actionButtonTitle: "Action!", actionButtonHandler: {
            self.onActionButtonTappedAtIndex(0)
        }),
        OnboardingItemInfo(imageName: UIImage.Asset.Banks.rawValue, title: "Banks", description: "Our smart algorithms scan social networks for trending places, bringing you up-to-date media for each place.", iconName: UIImage.Asset.Wallet.rawValue, color: UIColor(red:0.40, green:0.69, blue:0.71, alpha:1.00), titleFont: titleFont,descriptionFont: descriptionFont, actionButtonTitle: "Another Action...", actionButtonBackgroundColor: UIColor(colorLiteralRed: 0.5, green: 0, blue: 0, alpha: 1), actionButtonHandler: {
            self.onActionButtonTappedAtIndex(1)
        }),
        OnboardingItemInfo(imageName: UIImage.Asset.Stores.rawValue, title: "Stores", description: "When you get there, share the vibe with the community by taking photos and videos directly from Eyez.", iconName: UIImage.Asset.Shopping_Cart.rawValue, color: UIColor(red:0.61, green:0.56, blue:0.74, alpha:1.00), titleFont: titleFont,descriptionFont: descriptionFont)
    ]
    return items[index]
  }
  
  func onboardingItemsCount() -> Int {
    return 3
  }
}


// MARK: - Private Methods:

extension ViewController {
    
    private func onActionButtonTappedAtIndex(pageIndex: Int) {
        let alert = UIAlertController(title: "Hey", message: "Action button tapped at page \(pageIndex)!", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
            
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}
