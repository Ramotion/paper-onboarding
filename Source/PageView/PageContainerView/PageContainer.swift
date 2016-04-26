//
//  PageContaineView.swift
//  AnimatedPageView
//
//  Created by Alex K. on 13/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class PageContrainer: UIView {
  
  var items: [PageViewItem]?
  let space: CGFloat // space between items
  var currentIndex = 0
  
  private let itemRadius: CGFloat
  private let selectedItemRadius: CGFloat
  private let itemsCount: Int
  private let animationKey = "animationKey"
  
  private let animationDriver = AnimationDriver()
  
  init(radius: CGFloat, selectedRadius: CGFloat, space: CGFloat, itemsCount: Int) {
    self.itemsCount = itemsCount
    self.space = space
    self.itemRadius = radius
    self.selectedItemRadius = selectedRadius
    super.init(frame: CGRect.zero)
    items = createItems(itemsCount, radius: radius, selectedRadius: selectedRadius)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: public

extension PageContrainer {
  
  func currenteIndex(index: Int, duration: Double, animated: Bool) {
    guard let items = self.items where
      index != currentIndex else {return}
    
    animationItem(items[index], selected: true, duration: duration)
    
    let fillColor = index > currentIndex ? true : false
    animationItem(items[currentIndex], selected: false, duration: duration, fillColor: fillColor)
    
    currentIndex = index
  }
}

// MARK: animations 

extension PageContrainer {
  
  private func animationItem(item: PageViewItem, selected: Bool, duration: Double, fillColor: Bool = false) {
    item.select = selected
    item.tickIndex = 0
    animationDriver.addAnimationObject(item)
    
    // alpha animation 
    UIView.animateWithDuration(duration * 0.7, delay: 0, options: .CurveEaseOut, animations: {
      item.imageView?.alpha = selected == true ? 1 : 0
      item.borderView?.backgroundColor = fillColor == true ? .whiteColor() : .clearColor()
    }, completion: nil)
  }

}
// MARK: create

extension PageContrainer {
  
  private func createItems(count: Int, radius: CGFloat, selectedRadius: CGFloat) -> [PageViewItem] {
    var items = [PageViewItem]()
    // create first item 
    var item = createItem(radius, selectedRadius: selectedRadius, isSelect: true)
    addConstraintsToView(item, radius: selectedRadius)
    items.append(item)
    
    for _ in 1..<count {
      let nextItem = createItem(radius, selectedRadius: selectedRadius)
      addConstraintsToView(nextItem, leftItem: item, radius: radius)
      items.append(nextItem)
      item = nextItem
    }
    return items
  }
  
  private func createItem(radius: CGFloat, selectedRadius: CGFloat, isSelect: Bool = false) -> PageViewItem {
    let item = Init(PageViewItem(radius: radius, selectedRadius: selectedRadius, isSelect: isSelect)) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.backgroundColor = .clearColor()
    }
    self.addSubview(item)
    
    return item
  }
  
  private func addConstraintsToView(item: UIView, radius: CGFloat) {
    [NSLayoutAttribute.Left, NSLayoutAttribute.CenterY].forEach { attribute in
      (self, item) >>>- { $0.attribute = attribute }
    }
    
    [NSLayoutAttribute.Width, NSLayoutAttribute.Height].forEach { attribute in
      item >>>- {
        $0.attribute = attribute
        $0.constant = radius * 2.0
        $0.identifier = animationKey
      } 
    }
  }
  
  private func addConstraintsToView(item: UIView, leftItem: UIView, radius: CGFloat) {
    (self, item) >>>- { $0.attribute = .CenterY }
    
    (self, item, leftItem) >>>- {
      $0.attribute = .Leading
      $0.secondAttribute = .Trailing
      $0.constant = space
    }
    
    [NSLayoutAttribute.Width, NSLayoutAttribute.Height].forEach { attribute in
      item >>>- {
        $0.attribute = attribute
        $0.constant = radius * 2.0
        $0.identifier = animationKey
      } 
    }
  }
}