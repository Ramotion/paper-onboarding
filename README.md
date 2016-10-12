[![header](https://raw.githubusercontent.com/Ramotion/paper-onboarding/master/header.png)](https://business.ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding-logo)

# paper-onboarding
[![Twitter](https://img.shields.io/badge/Twitter-@Ramotion-blue.svg?style=flat)](http://twitter.com/Ramotion)
[![CocoaPods](https://img.shields.io/cocoapods/p/paper-onboarding.svg)](https://cocoapods.org/pods/paper-onboarding)
[![CocoaPods](https://img.shields.io/cocoapods/v/paper-onboarding.svg)](http://cocoapods.org/pods/paper-onboarding)
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/paper-onboarding.svg)](https://cdn.rawgit.com/Ramotion/paper-onboarding/master/docs/index.html)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Ramotion/paper-onboarding)
[![Travis](https://img.shields.io/travis/Ramotion/paper-onboarding.svg)](https://travis-ci.org/Ramotion/paper-onboarding)
[![codebeat badge](https://codebeat.co/badges/d06237c6-6ff7-4560-9602-b6cc65063383)](https://codebeat.co/projects/github-com-ramotion-paper-onboarding)
[![Analytics](https://ga-beacon.appspot.com/UA-84973210-1/ramotion/paper-onboarding)](https://github.com/igrigorik/ga-beacon)


## About
This project is maintained by Ramotion, an agency specialized in building dedicated engineering teams and developing custom software.<br><br> [Contact our team](https://business.ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding-contact-us) and we’ll help you work with the best engineers from Eastern Europe.

<p align="center">
<a href="https://dribbble.com/shots/2694049-iOS-Pagination-Controller-Open-Source"><img src="https://raw.githubusercontent.com/Ramotion/paper-onboarding/master/preview.gif" width="890" height="668" alt="StackViewController Example App" /></a>
</p>

The [iPhone mockup](https://store.ramotion.com/product/iphone-6-mockups?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding) available [here](https://store.ramotion.com/product/iphone-6-mockups?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding).

## Requirements

- iOS 9.0+
- Xcode 8

## Installation

Just add the Source folder to your project.

or use [CocoaPods](https://cocoapods.org) with Podfile:
``` ruby
pod 'paper-onboarding', '~> 1.1.3' swift 2.2

pod 'paper-onboarding', '~> 2.0.0' swift 3
```

or [Carthage](https://github.com/Carthage/Carthage) users can simply add to their `Cartfile`:
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
## License

paper-onboarding is released under the MIT license.
See [LICENSE](./LICENSE) for details.


## Follow Us

[![Twitter URL](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=https://github.com/ramotion/paper-onboarding)
[![Twitter Follow](https://img.shields.io/twitter/follow/ramotion.svg?style=social)](https://twitter.com/ramotion)
