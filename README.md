![header](./header.png)
![animation](./preview.gif)

# PaperOnboarding
[![Twitter](https://img.shields.io/badge/Twitter-@Ramotion-blue.svg?style=flat)](http://twitter.com/Ramotion)
[![CocoaPods](https://img.shields.io/cocoapods/p/paper-onboarding.svg)](https://cocoapods.org/pods/paper-onboarding)
[![CocoaPods](https://img.shields.io/cocoapods/v/paper-onboarding.svg)](http://cocoapods.org/pods/paper-onboarding)
[![Documentation](https://cdn.rawgit.com/Ramotion/paper-onboarding/master/docs/badge.svg)](https://cdn.rawgit.com/Ramotion/paper-onboarding/master/docs/index.html)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Ramotion/paper-onboarding)
[![Travis](https://img.shields.io/travis/Ramotion/paper-onboarding.svg)](https://travis-ci.org/Ramotion/paper-onboarding)
[![codebeat badge](https://codebeat.co/badges/d06237c6-6ff7-4560-9602-b6cc65063383)](https://codebeat.co/projects/github-com-ramotion-paper-onboarding)

# Check this library on other platforms:
<a href="https://github.com/Ramotion/paper-onboarding-android">
<img src="https://github.com/ramotion/navigation-stack/raw/master/Android_Java@2x.png" width="178" height="81"></a>

**Looking for developers for your project?**<br>
This project is maintained by Ramotion, Inc. We specialize in the designing and coding of custom UI for Mobile Apps and Websites.

<a href="https://ramotion.com/?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding-contact-us/#Get_in_Touch">
<img src="https://github.com/ramotion/gliding-collection/raw/master/contact_our_team@2x.png" width="187" height="34"></a> <br>

The [iPhone mockup](https://store.ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding) available [here](https://store.ramotion.com?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding).

## Requirements

- iOS 8.0+
- tvOS 9.0+
- Xcode 8

## Installation

Just add the Source folder to your project.

or use [CocoaPods](https://cocoapods.org) with Podfile:
``` ruby
pod 'paper-onboarding', '~> 1.1.3' # Swift 2.2

pod 'PaperOnboarding', '~> 2.3' # Swift 3

pod 'PaperOnboarding', '~> 3.0' # Swift 4
```

or [Carthage](https://github.com/Carthage/Carthage) users can simply add to their `Cartfile`:
```
github "Ramotion/paper-onboarding"
```

## Usage

#### Storyboard

1) Create a new UIView inheriting from `PaperOnboarding`

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

#### configuring content item:

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

<br>

# Get the Showroom App for iOS to give it a try
Try this UI component and more like this in our iOS app. Contact us if interested.

<a href="https://itunes.apple.com/app/apple-store/id1182360240?pt=550053&ct=paper-onboarding&mt=8" >
<img src="https://github.com/ramotion/gliding-collection/raw/master/app_store@2x.png" width="117" height="34"></a>

<a href="https://ramotion.com/?utm_source=gthb&utm_medium=special&utm_campaign=paper-onboarding-contact-us/#Get_in_Touch">
<img src="https://github.com/ramotion/gliding-collection/raw/master/contact_our_team@2x.png" width="187" height="34"></a>
<br>
<br>

Follow us for the latest updates<br>
[![Twitter URL](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=https://github.com/ramotion/paper-onboarding)
[![Twitter Follow](https://img.shields.io/twitter/follow/ramotion.svg?style=social)](https://twitter.com/ramotion)
