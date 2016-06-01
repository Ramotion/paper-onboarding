![header](./header.png)

# paper-onboarding
[![Twitter](https://img.shields.io/badge/Twitter-@Ramotion-blue.svg?style=flat)](http://twitter.com/Ramotion)
[![CocoaPods](https://img.shields.io/cocoapods/p/paper-onboarding.svg)](https://cocoapods.org/pods/paper-onboarding)
[![CocoaPods](https://img.shields.io/cocoapods/v/paper-onboarding.svg)](http://cocoapods.org/pods/paper-onboarding)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Ramotion/paper-onboarding)
[![Travis](https://img.shields.io/travis/Ramotion/paper-onboarding.svg)](https://travis-ci.org/Ramotion/paper-onboarding)
[![codebeat badge](https://codebeat.co/badges/d06237c6-6ff7-4560-9602-b6cc65063383)](https://codebeat.co/projects/github-com-ramotion-paper-onboarding)

[shot on dribbble](https://dribbble.com/shots/2694049-iOS-Pagination-Controller-Open-Source):

<p align="center">
<a href="https://dribbble.com/shots/2694049-iOS-Pagination-Controller-Open-Source"><img src="preview.gif" width="890" height="668" alt="StackViewController Example App" /></a>
</p>

The [iPhone mockup](https://store.ramotion.com/product/iphone-6-mockups?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding) available [here](https://store.ramotion.com/product/iphone-6-mockups?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding).

## Requirements

- iOS 8.0+
- Xcode 7.3

## Installation

Just add the Source folder to your project.

or use [CocoaPods](https://cocoapods.org) with Podfile:
``` ruby
pod 'paper-onboarding'
```

or [Carthage](https://github.com/Carthage/Carthage) users can simply add Mantle to their `Cartfile`:
```
github "Ramotion/paper-onboarding"
```

## Usage

#### Storyboard

1) Create a new UIView inheriting from ```PaperOnboarding```

2) Set dataSource in attribute inspector

#### or Code

``` swift
override func viewDidLoad() {
  super.viewDidLoad()

  let onboarding = PaperOnboarding(itemsCount: 3)
  onboarding.dataSource = self
  onboarding.translatesAutoresizingMaskIntoConstraints = false
  view.addSubview(onboarding)

  // add constraints
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

#### For adding content use dataSource methods:

``` swift
func onboardingItemAtIndex(index: Int) -> OnboardingItemInfo {
   return [
     ("BIG_IMAGE1", "Title", "Description text", "IconName1", "BackgroundColor", textColor, DescriptionColor, textFont, DescriptionFont),
     ("BIG_IMAGE1", "Title", "Description text", "IconName1", "BackgroundColor", textColor, DescriptionColor, textFont, DescriptionFont),
     ("BIG_IMAGE1", "Title", "Description text", "IconName1", "BackgroundColor", textColor, DescriptionColor, textFont, DescriptionFont)
   ][index]
 }

 func onboardingItemsCount() -> Int {
    return 3
  }

```

#### configuration contant item:

``` swift
func onboardingConfigurationItem(item: OnboardingContentViewItem, index: Int) {

//    item.titleLabel?.backgroundColor = .redColor()
//    item.descriptionLabel?.backgroundColor = .redColor()
//    item.imageView = ...
  }
```
##Actions to do once the walkthrough is done

```swift
optional func onboardingWillTransitonToIndex(index: Int){
	///Do what you want..

}
optional func onboardingDidTransitonToIndex(index: Int){
	///Do what you want..

}
```
## License

paper-onboarding is released under the MIT license.
See [LICENSE](./LICENSE) for details.


## About
Maintained by [app development agency](https://ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding) [Ramotion Inc.](https://ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding)
See our other [open-source projects](https://github.com/ramotion) or [hire](https://ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding) us to design, develop, and grow your product.

[![Twitter URL](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=https://github.com/ramotion/paper-onboarding)
[![Twitter Follow](https://img.shields.io/twitter/follow/ramotion.svg?style=social)](https://twitter.com/ramotion)
