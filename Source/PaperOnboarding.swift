//
//  PaperOnboarding.swift
//  AnimatedPageView
//
//  Created by Alex K. on 20/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

//..
//
public typealias OnboardingItemInfo = (imageName: String, title: String, description: String, iconName: String, color: UIColor, titleColor: UIColor, descriptionColor: UIColor, titleFont: UIFont, descriptionFont: UIFont)

public protocol PaperOnboardingDataSource {
  func onboardingItemAtIndex(index: Int) -> OnboardingItemInfo
}

public protocol PaperOnboardingDelegate {
  func onboardingWillTransitonToIndex(index: Int)
  func onboardingDidTransitonToIndex(index: Int)
}

public class PaperOnboarding: UIView {

  @IBOutlet public var dataSource: AnyObject? //PaperOnboardingDataSource
  @IBOutlet public var delegate: AnyObject? //PaperOnboardingDelegate
  public private(set) var currentIndex: Int = 0
  @IBInspectable var itemsCount: Int = 3

  private var itemsInfo: [OnboardingItemInfo]?

  private var pageViewBottomConstant: CGFloat = 32
  private var pageViewSelectedRadius: CGFloat = 22
  private var pageViewRadius: CGFloat         = 8

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
      (self.delegate as? PaperOnboardingDelegate)?.onboardingWillTransitonToIndex(index)
      currentIndex = index
      CATransaction.begin()


      CATransaction.setCompletionBlock({
        (self.delegate as? PaperOnboardingDelegate)?.onboardingDidTransitonToIndex(index)
      })


      if let postion = pageView?.positionItemIndex(index, onView: self) {
        fillAnimationView?.fillAnimation(bakcgroundColor(currentIndex), centerPosition: postion, duration: 0.5)
      }
      pageView?.currentIndex(index, animated: animated)
      contentView?.currentItem(index, animated: animated)
      CATransaction.commit()
    }

  }
}
// MARK: create

extension PaperOnboarding {

  private func commonInit() {
    itemsInfo = createItemsInfo()
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
      if let iconName = self.itemsInfo?[index].iconName {
        item.imageView?.image = UIImage(named: iconName)
      }
    }
    return pageView
  }

  private func createItemsInfo() -> [OnboardingItemInfo] {
    guard case let dataSource as PaperOnboardingDataSource = self.dataSource else {
      fatalError("set dataSource")
    }

    var items = [OnboardingItemInfo]()
    for index in 0..<itemsCount {
      let info = dataSource.onboardingItemAtIndex(index)
      items.append(info)
    }
    return items
  }

}

// MARK: helpers

extension PaperOnboarding {

  private func bakcgroundColor(index: Int) -> UIColor {
    guard let color = itemsInfo?[index].color else {
      return .blackColor()
    }
    return color
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
    return itemsInfo?[index]
  }
}
