//
//  PaperOnboarding.swift
//  AnimatedPageView
//
//  Created by Alex K. on 20/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

public typealias OnboardingItemInfo = (imageName: String, title: String, description: String)

public protocol PaperOnboardingDataSource {
  func onboardingItemAtIndex(index: Int) -> OnboardingItemInfo
  func onboardingBackgroundColorItemAtIndex(index: Int) -> UIColor
  func pageViewIconAtIndex(index: Int) -> UIImage?
}

public class PaperOnboarding: UIView {
  
  @IBOutlet public var dataSource: AnyObject? //PaperOnboardingDataSource
  
  public private(set) var currentIndex: Int = 0
  @IBInspectable var itemsCount: Int = 3
  
  private var pageViewBottomConstant: CGFloat = 32
  private var pageViewSelectedRadius: CGFloat = 22
  private var pageViewRadius: CGFloat = 8
  
  private var fillAnimationView: FillAnimationView?
  private var pageView: PageView?
  private var gestureControl: GestureControl?
  private var contentView: OnboardingContentView?
  
  public init(itemsCount: Int = 3, dataSource: PaperOnboardingDataSource) {
    super.init(frame: CGRect.zero)
    self.dataSource = dataSource as? AnyObject
    self.itemsCount = itemsCount
    commonInit()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
}

// MARK: public

public extension PaperOnboarding {
  
  func currentIndex(index: Int, animated: Bool) {
    if 0 ..< itemsCount ~= index {
      currentIndex = index
      if let postion = pageView?.positionItemIndex(index, onView: self) {
        fillAnimationView?.fillAnimation(bakcgroundColor(currentIndex), centerPosition: postion, duration: 0.6)
      }
      pageView?.currentIndex(index, animated: animated)
      contentView?.currentItem(index, animated: animated)
    }
    
  }
}
// MARK: create

extension PaperOnboarding {
  
  private func commonInit() {
    translatesAutoresizingMaskIntoConstraints = false
    fillAnimationView = FillAnimationView.animavtionViewOnView(self, color: bakcgroundColor(currentIndex))
    contentView = OnboardingContentView.contentViewOnView(self,
                                                          delegate: self,
                                                          itemsCount: itemsCount,
                                                          bottomConstant: pageViewBottomConstant * -1 - pageViewSelectedRadius)
    pageView = createPageView()
    gestureControl = GestureControl(view: self, delegate: self)
  }
  
  private func createPageView() -> PageView {
    let pageView = PageView.pageViewOnView(self,
                                          itemsCount: itemsCount,
                                          bottomConstant: pageViewBottomConstant * -1,
                                          radius:pageViewRadius,
                                          selectedRadius: pageViewSelectedRadius)
    pageView.configuration = { item, index in
      if case let dataSource as PaperOnboardingDataSource = self.dataSource {
        let icon = dataSource.pageViewIconAtIndex(index)
        item.imageView?.image = icon
      }
    }
    return pageView
  }

}

// MARK: helpers 

extension PaperOnboarding {
  
  private func bakcgroundColor(index: Int) -> UIColor {
    if case let dataSource as PaperOnboardingDataSource = self.dataSource {
      return dataSource.onboardingBackgroundColorItemAtIndex(currentIndex)
    }
    return .blackColor()
  }

}

// MARK: GestureControlDelegate

extension PaperOnboarding: GestureControlDelegate {
  
  func gestureControlDidSwipe(direction: UISwipeGestureRecognizerDirection) {
    switch direction {
    case UISwipeGestureRecognizerDirection.Right:
      currentIndex(currentIndex - 1, animated: true)
    case UISwipeGestureRecognizerDirection.Left:
      currentIndex(currentIndex + 1, animated: true)
    default:
      fatalError()
    }
  }
}

// MARK: OnboardingDelegate 

extension PaperOnboarding: OnboardingContentViewDelegate {
  
  func onboardingItemAtIndex(index: Int) -> OnboardingItemInfo? {
    guard case let dataSource as PaperOnboardingDataSource = self.dataSource else {
      return nil
    }
    return dataSource.onboardingItemAtIndex(index)
  }
}