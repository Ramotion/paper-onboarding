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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        skipButton.isHidden = true

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

    @IBAction func buttnoHandler(_ sender: AnyObject) {
    }
}

// MARK: Actions

extension ViewController {

    @IBAction func buttonHandler(_ sender: AnyObject) {
        print("skip handler")
    }
}

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

        let items: [OnboardingItemInfo] = [
                OnboardingItemInfo(imageName: UIImage.Asset.Hotels.rawValue, title: "Hotels", description: "All hotels and hostels are sorted by hospitality rating", iconName: UIImage.Asset.Key.rawValue, color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00), titleFont: titleFont, descriptionFont: descriptionFont, actionButtonTitle: "Action!", actionButtonBackgroundColor: UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 1), actionButtonHandler: {
                    self.onActionButtonTappedAtIndex(pageIndex: 0)
                }),
                OnboardingItemInfo(imageName: UIImage.Asset.Banks.rawValue, title: "Banks", description: "We carefully verify all banks before add them into the app", iconName: UIImage.Asset.Wallet.rawValue, color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00), titleFont: titleFont, descriptionFont: descriptionFont, actionButtonTitle: "Another Action...", actionButtonBackgroundColor: UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 1), actionButtonHandler: {
                    self.onActionButtonTappedAtIndex(pageIndex: 1)
                }),
                OnboardingItemInfo(imageName: UIImage.Asset.Stores.rawValue, title: "Stores", description: "All local stores are categorized for your convenience", iconName: UIImage.Asset.Shopping_Cart.rawValue, color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00), titleFont: titleFont, descriptionFont: descriptionFont)
        ]
        return items[index]
    }

    func onboardingItemsCount() -> Int {
        return 3
    }
}

// MARK: - Private Methods:

extension ViewController {

    func onActionButtonTappedAtIndex(pageIndex: Int) {
        let alert = UIAlertController(title: "Hey", message: "Action button tapped at page \(pageIndex)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
        }))

        self.present(alert, animated: true, completion: nil)
    }
}
