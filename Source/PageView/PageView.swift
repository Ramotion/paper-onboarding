//
//  PageView.swift
//  AnimatedPageView
//
//  Created by Alex K. on 13/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class PageView: UIView {
  
  var itemsCount                  = 3
  var itemRadius: CGFloat         = 8.0
  var selectedItemRadius: CGFloat = 22.0
  var duration: Double            = 0.7
  var space: CGFloat              = 20// space between items

  // configure items set image or chage color for border view
  var configuration: ((_ item: PageViewItem, _ index: Int) -> Void)? {
    didSet {
      configurePageItems(containerView?.items)
    }
  }
  
  fileprivate var containerX: NSLayoutConstraint?
  var containerView: PageContrainer?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  init(frame: CGRect, itemsCount: Int, radius: CGFloat, selectedRadius: CGFloat) {
    self.itemsCount         = itemsCount
    self.itemRadius         = radius
    self.selectedItemRadius = selectedRadius
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    guard
      let containerView = self.containerView,
      let items = containerView.items
      else { return nil }
    for item in items {
      let frame = item.frame.insetBy(dx: -10, dy: -10)
      guard frame.contains(point) else { continue }
      return item
    }
    return nil
  }
  
}

// MARK: public

extension PageView {
  
  class func pageViewOnView(_ view: UIView, itemsCount: Int, bottomConstant: CGFloat, radius: CGFloat, selectedRadius: CGFloat) -> PageView {
   let pageView = Init(PageView(frame: CGRect.zero, itemsCount: itemsCount, radius: radius, selectedRadius: selectedRadius)) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.alpha                                     = 0.4
    }
    view.addSubview(pageView)
    
    // add constraints 
    for (attribute, const) in [(NSLayoutAttribute.left, 0), (NSLayoutAttribute.right, 0), (NSLayoutAttribute.bottom, bottomConstant)] {
      (view, pageView) >>>- {
        $0.constant  = CGFloat(const)
        $0.attribute = attribute
        return
      }
    }
    pageView >>>- {
      $0.attribute = .height
      $0.constant  = 30
      return
    }

    return pageView
  }

  func currentIndex(_ index: Int, animated: Bool) {
    
    if 0..<itemsCount ~= index {
      containerView?.currenteIndex(index, duration: duration * 0.5, animated: animated)
      moveContainerTo(index, animated: animated, duration: duration)
    }
  }
  
  func positionItemIndex(_ index: Int, onView: UIView) -> CGPoint? {
    if 0..<itemsCount ~= index {
      if let currentItem = containerView?.items?[index].imageView {
        let pos = currentItem.convert(currentItem.center, to: onView)
        return pos
      }
    }
    return nil
  }
}

// MARK: life cicle

extension PageView {
  
  fileprivate func commonInit() {
    containerView = createContainerView()
    currentIndex(0, animated: false)
    self.backgroundColor = .clear
  }
}

// MARK: create

extension PageView {
  
  fileprivate func createContainerView() -> PageContrainer {
    let container = Init(PageContrainer(radius: itemRadius, selectedRadius: selectedItemRadius, space: space, itemsCount: itemsCount)) {
      $0.backgroundColor                           = .clear
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    self.addSubview(container)
    
    // add constraints 
    for attribute in [NSLayoutAttribute.top, NSLayoutAttribute.bottom] {
      (self, container) >>>- { $0.attribute = attribute; return }
    }

    containerX = (self, container) >>>- { $0.attribute = .centerX; return }

    container >>>- {
      $0.attribute = .width
      $0.constant  = selectedItemRadius * 2 + CGFloat(itemsCount - 1) * (itemRadius * 2) + space * CGFloat(itemsCount - 1)
      return
    }
    return container
  }
  
  fileprivate func configurePageItems(_ items: [PageViewItem]?) {
    guard let items = items else {
      return
    }
    for index in 0..<items.count {
      configuration?(items[index], index)
    }
  }

}

// MARK: animation

extension PageView {
  
  fileprivate func moveContainerTo(_ index: Int, animated: Bool = true, duration: Double = 0) {
    guard let containerX = self.containerX else {
      return
    }
    
    let containerWidth  = CGFloat(itemsCount + 1) * selectedItemRadius + space * CGFloat(itemsCount - 1)
    let toValue         = containerWidth / 2.0 - selectedItemRadius - (selectedItemRadius + space) * CGFloat(index)
    containerX.constant = toValue
    
    if animated == true {
      UIView.animate(withDuration: duration,
                                 delay: 0,
                                 options: UIViewAnimationOptions(),
                                 animations: {
                                  self.layoutIfNeeded()
                                 },
                                 completion: nil)
    } else {
      layoutIfNeeded()
    }
  }
}
 
