<!-- ![header](./header.png) -->

# paper-onboarding
[![Twitter](https://img.shields.io/badge/Twitter-@Ramotion-blue.svg?style=flat)](http://twitter.com/Ramotion)
[![CocoaPods](https://img.shields.io/cocoapods/p/paper-onboarding.svg)](https://cocoapods.org/pods/paper-onboarding)
[![CocoaPods](https://img.shields.io/cocoapods/v/paper-onboarding.svg)](http://cocoapods.org/pods/paper-onboarding)
[![Travis](https://img.shields.io/travis/Ramotion/navigation-stack.svg)](https://travis-ci.org/Ramotion/navigation-stack)
[![codebeat badge](https://codebeat.co/badges/d06237c6-6ff7-4560-9602-b6cc65063383)](https://codebeat.co/projects/github-com-ramotion-paper-onboarding)

<!-- [shot on dribbble](https://dribbble.com/shots/2583175-Navigation-Stack-Swift-Open-Source): -->
<!-- ![Animation](Navigation-Stack.gif) -->

<p align="center">
<img src="preview.gif" width="800" height="600" alt="StackViewController Example App" />
</p>

## Requirements

- iOS 8.0+
- Xcode 7.3

## Installation

Just add the Source folder to your project.

or use [CocoaPods](https://cocoapods.org) with Podfile:
``` ruby
pod 'Navigation-stack', '~> 0.0.2'
```

## Usage

#### Storyboard

1) Create a new UIView inheriting from ```PaperOnboarding```

2) Set itemsCount in attribute inspector

#### or Code

``` swift
override func viewDidLoad() {
  super.viewDidLoad()

  let onboarding = PaperOnboarding(itemsCount: 3, dataSource: self)
  onboarding.translatesAutoresizingMaskIntoConstraints = false
  view.addSubview(onboarding)

  // add constratins
  for attribute: NSLayoutAttribute in [.Left, .Right, .Top, .Bottom] {
    let constraint = NSLayoutConstraint(item: onboarding,
                                        attribute: attribute,
                                        relatedBy: .Equal,
                                        toItem: view,
                                        attribute: attribute,
                                        multiplier: 1,
                                        constant: 0)
    view.addConstraint(constraint)
  }
}
```

#### For adding content use delegate methods:

``` swift
func onboardingItemAtIndex(index: Int) -> OnboardingItemInfo {
   return [
     ("BIG_IMAGE1", "Hotels", "All hotels and hostels are sorted by hospitality rating"),
     ("BIG_IMAGE2", "Banks", "We carefully verify all banks before add them into the app"),
     ("BIG_IMAGE3", "Stores", "All local stores are categorized for your convenience")
   ][index]
 }

 func onboardingBackgroundColorItemAtIndex(index: Int) -> UIColor {
   return [
     UIColor(red:0.40, green:0.56, blue:0.71, alpha:1.00),
     UIColor(red:0.40, green:0.69, blue:0.71, alpha:1.00),
     UIColor(red:0.61, green:0.56, blue:0.74, alpha:1.00)][index]
 }

 func pageViewIconAtIndex(index: Int) -> UIImage? {
   let imageNames = ["ICON1", "ICON2", "ICON3"]
   return UIImage(asset: imageNames[index])
 }
```

## Licence

paper-onboarding is released under the MIT license.
See [LICENSE](./LICENSE) for details.


## About
The project maintained by [app development agency](https://ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding) [Ramotion Inc.](https://ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding)
See our other [open-source projects](https://github.com/ramotion) or [hire](https://ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding) us to design, develop, and grow your product.

[![Twitter URL](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=https://github.com/ramotion/paper-onboarding)
[![Twitter Follow](https://img.shields.io/twitter/follow/ramotion.svg?style=social)](https://twitter.com/ramotion)
