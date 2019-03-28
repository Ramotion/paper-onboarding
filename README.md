<img src="https://github.com/Ramotion/folding-cell/blob/master/header.png">

<a href="https://github.com/Ramotion/folding-cell">
<img align="left" src="https://github.com/Ramotion/paper-onboarding/blob/master/paper-onboarding.gif" width="480" height="360" /></a>

<p><h1 align="left">PAPER ONBOARDING</h1></p>

<h4>iOS library Paper Onboarding is a material design UI slider written on Swift.</h4>


___



<p><h6>We specialize in the designing and coding of custom UI for Mobile Apps and Websites.</h6>
<a href="https://dev.ramotion.com?utm_source=gthb&utm_medium=repo&utm_campaign=paper-onboarding">
<img src="https://github.com/ramotion/gliding-collection/raw/master/contact_our_team@2x.png" width="187" height="34"></a>
</p>
<p><h6>Stay tuned for the latest updates:</h6>
<a href="https://goo.gl/rPFpid" >
<img src="https://i.imgur.com/ziSqeSo.png/" width="156" height="28"></a></p>
<h6><a href="https://store.ramotion.com/product/iphone-x-clay-mockups?utm_source=gthb&utm_medium=special&utm_campaign=folding-cell#demo">Get Free Mockup For your project →</a></h6>

</br>

[![Twitter](https://img.shields.io/badge/Twitter-@Ramotion-blue.svg?style=flat)](http://twitter.com/Ramotion)
[![CocoaPods](https://img.shields.io/cocoapods/p/paper-onboarding.svg)](https://cocoapods.org/pods/paper-onboarding)
[![CocoaPods](https://img.shields.io/cocoapods/v/paper-onboarding.svg)](http://cocoapods.org/pods/paper-onboarding)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Ramotion/paper-onboarding)
[![Travis](https://img.shields.io/travis/Ramotion/paper-onboarding.svg)](https://travis-ci.org/Ramotion/paper-onboarding)
[![codebeat badge](https://codebeat.co/badges/d06237c6-6ff7-4560-9602-b6cc65063383)](https://codebeat.co/projects/github-com-ramotion-paper-onboarding)
[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://paypal.me/Ramotion)

## Requirements

- iOS 10.0+
- Xcode 10.2

## Installation

Just add the Source folder to your project.

or use [CocoaPods](https://cocoapods.org) with Podfile:

``` ruby
pod 'paper-onboarding'
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
  func onboardingItem(at index: Int) -> OnboardingItemInfo {

   return [
     OnboardingItemInfo(informationImage: IMAGE,
                                   title: "title",
                             description: "description",
                                pageIcon: IMAGE,
                                   color: UIColor.RANDOM,
                              titleColor: UIColor.RANDOM,
                        descriptionColor: UIColor.RANDOM,
                               titleFont: UIFont.FONT,
                         descriptionFont: UIFont.FONT),

     OnboardingItemInfo(informationImage: IMAGE,
                                    title: "title",
                              description: "description",
                                 pageIcon: IMAGE,
                                    color: UIColor.RANDOM,
                               titleColor: UIColor.RANDOM,
                         descriptionColor: UIColor.RANDOM,
                                titleFont: UIFont.FONT,
                          descriptionFont: UIFont.FONT),

    OnboardingItemInfo(informationImage: IMAGE,
                                 title: "title",
                           description: "description",
                              pageIcon: IMAGE,
                                 color: UIColor.RANDOM,
                            titleColor: UIColor.RANDOM,
                      descriptionColor: UIColor.RANDOM,
                             titleFont: UIFont.FONT,
                       descriptionFont: UIFont.FONT)
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


## 🗂 Check this library on other language:
<a href="https://github.com/Ramotion/paper-onboarding-android">
<img src="https://github.com/ramotion/navigation-stack/raw/master/Android_Java@2x.png" width="178" height="81"></a>


## 📄 License

Paper Onboarding is released under the MIT license.
See [LICENSE](./LICENSE) for details.

This library is a part of a <a href="https://github.com/Ramotion/swift-ui-animation-components-and-libraries"><b>selection of our best UI open-source projects.</b></a>

If you use the open-source library in your project, please make sure to credit and backlink to www.ramotion.com

## 📱 Get the Showroom App for iOS to give it a try
Try this UI component and more like this in our iOS app. Contact us if interested.

<a href="https://itunes.apple.com/app/apple-store/id1182360240?pt=550053&ct=paper-onboarding&mt=8" >
<img src="https://github.com/ramotion/gliding-collection/raw/master/app_store@2x.png" width="117" height="34"></a>

<a href="https://dev.ramotion.com?utm_source=gthb&utm_medium=repo&utm_campaign=paper-onboarding">
<img src="https://github.com/ramotion/gliding-collection/raw/master/contact_our_team@2x.png" width="187" height="34"></a>
<br>
<br>
