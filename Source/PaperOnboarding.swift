//
//  PaperOnboarding.swift
//  AnimatedPageView
//
//  Created by Alex K. on 20/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

public typealias OnboardingItemInfo = (imageName: UIImage, title: String, description: String, iconName: UIImage, color: UIColor, titleColor: UIColor, descriptionColor: UIColor, titleFont: UIFont, descriptionFont: UIFont)


///An instance of PaperOnboarding which display collection of information.
open class PaperOnboarding: UIView {
  
  ///  The object that acts as the data source of the  PaperOnboardingDataSource.
  @IBOutlet open var dataSource: AnyObject? {
    didSet {
      commonInit()
    }
  }
  
  /// The object that acts as the delegate of the PaperOnboarding. PaperOnboardingDelegate protocol
  @IBOutlet open var delegate: AnyObject?
  
  /// current index item
  open fileprivate(set) var currentIndex: Int = 0
  var itemsCount: Int = 3
  
  fileprivate var itemsInfo: [OnboardingItemInfo]?
  
  fileprivate var pageViewBottomConstant: CGFloat = 32
  fileprivate var pageViewSelectedRadius: CGFloat = 22
  fileprivate var pageViewRadius: CGFloat         = 8
  
  fileprivate var fillAnimationView: FillAnimationView?
  fileprivate var pageView: PageView?
  fileprivate var gestureControl: GestureControl?
  fileprivate var contentView: OnboardingContentView?
  
  /**
   Initializes and returns a PaperOnboarding object with items count.
   
   - parameter itemsCount: The number of items in PaperOnboarding.
   
   - returns: Returns an initialized PaperOnboading object
   */
  public init(itemsCount: Int = 3) {
    super.init(frame: CGRect.zero)
    self.itemsCount = itemsCount
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

// MARK: methods
public extension PaperOnboarding {
  
  /**
   Scrolls through the PaperOnboarding until a index is at a particular location on the screen.
   
   - parameter index:    Scrolling to a curretn index item.
   - parameter animated: True if you want to animate the change in position; false if it should be immediate.
   */
  func currentIndex(_ index: Int, animated: Bool) {
    if 0 ..< itemsCount ~= index {
      (self.delegate as? PaperOnboardingDelegate)?.onboardingWillTransitonToIndex(index)
      currentIndex = index
      CATransaction.begin()
      
      
      CATransaction.setCompletionBlock({
        (self.delegate as? PaperOnboardingDelegate)?.onboardingDidTransitonToIndex(index)
      })
      
      
      if let postion = pageView?.positionItemIndex(index, onView: self) {
        fillAnimationView?.fillAnimation(backgroundColor(currentIndex), centerPosition: postion, duration: 0.5)
      }
      pageView?.currentIndex(index, animated: animated)
      contentView?.currentItem(index, animated: animated)
      CATransaction.commit()
    }
    
  }
}

// MARK: create
extension PaperOnboarding {
  
  fileprivate func commonInit() {
    if case let dataSource as PaperOnboardingDataSource = self.dataSource {
      itemsCount = dataSource.onboardingItemsCount()
    }
    
    itemsInfo = createItemsInfo()
    translatesAutoresizingMaskIntoConstraints = false
    fillAnimationView = FillAnimationView.animavtionViewOnView(self, color: backgroundColor(currentIndex))
    contentView = OnboardingContentView.contentViewOnView(self,
                                                          delegate: self,
                                                          itemsCount: itemsCount,
                                                          bottomConstant: pageViewBottomConstant * -1 - pageViewSelectedRadius)
    pageView = createPageView()
    gestureControl = GestureControl(view: self, delegate: self)
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
    addGestureRecognizer(tapGesture)
  }
  
  @objc fileprivate func tapAction(_ sender: UITapGestureRecognizer) {
    guard
      (self.delegate as? PaperOnboardingDelegate)?.enableTapsOnPageControl == true,
      let pageView = self.pageView,
      let pageControl = pageView.containerView
      else { return }
    let touchLocation = sender.location(in: self)
    let convertedLocation = pageControl.convert(touchLocation, from: self)
    guard let pageItem = pageView.hitTest(convertedLocation, with: nil) else { return }
    let index = pageItem.tag - 1
    guard index != currentIndex else { return }
    currentIndex(index, animated: true)
    (delegate as? PaperOnboardingDelegate)?.onboardingWillTransitonToIndex(index)
  }
  
  fileprivate func createPageView() -> PageView {
    let pageView = PageView.pageViewOnView(self,
                                           itemsCount: itemsCount,
                                           bottomConstant: pageViewBottomConstant * -1,
                                           radius:pageViewRadius,
                                           selectedRadius: pageViewSelectedRadius)
    
    pageView.configuration = { item, index in
        item.imageView?.image = self.itemsInfo?[index].iconName
    }
    
    return pageView
  }
  
  fileprivate func createItemsInfo() -> [OnboardingItemInfo] {
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
  
  fileprivate func backgroundColor(_ index: Int) -> UIColor {
    guard let color = itemsInfo?[index].color else {
      return .black
    }
    return color
  }
}

// MARK: GestureControlDelegate
extension PaperOnboarding: GestureControlDelegate {
  
  func gestureControlDidSwipe(_ direction: UISwipeGestureRecognizerDirection) {
    switch direction {
    case UISwipeGestureRecognizerDirection.right:
      currentIndex(currentIndex - 1, animated: true)
    case UISwipeGestureRecognizerDirection.left:
      currentIndex(currentIndex + 1, animated: true)
    default:
      fatalError()
    }
  }
}

// MARK: OnboardingDelegate
extension PaperOnboarding: OnboardingContentViewDelegate {
  
  func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo? {
    return itemsInfo?[index]
  }
  
  func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
    delegate?.onboardingConfigurationItem(item, index: index)
  }
  
}
