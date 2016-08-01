//
//  OnboardingContentView.swift
//  AnimatedPageView
//
//  Created by Alex K. on 21/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

protocol OnboardingContentViewDelegate {

  func onboardingItemAtIndex(index: Int) -> OnboardingItemInfo?
  func onboardingConfigurationItem(item: OnboardingContentViewItem, index: Int)
}

class OnboardingContentView: UIView {

  private struct Constants {
    static let dyOffsetAnimation: CGFloat = 110
    static let showDuration: Double       = 0.8
    static let hideDuration: Double       = 0.2
  }

  private var currentItem: OnboardingContentViewItem?
  private var actionButtonHandlerCallback: (() -> Void)? = nil
    
  var delegate: OnboardingContentViewDelegate

  init(itemsCount: Int, delegate: OnboardingContentViewDelegate) {
    self.delegate = delegate
    super.init(frame: CGRect.zero)

    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: public
extension OnboardingContentView {

  func currentItem(index: Int, animated: Bool) {

    let showItem = createItem(index)
    showItemView(showItem, duration: Constants.showDuration)

    hideItemView(currentItem, duration: Constants.hideDuration)

    currentItem = showItem
  }

  func getCurrentActionButtonFrame() -> CGRect? {
    return currentItem?.getActionButtonFrame()
  }
    
  func actionButtonWasTapped() {
    actionButtonHandlerCallback?()
  }
}

// MARK: life cicle

extension OnboardingContentView {

  class func contentViewOnView(view: UIView, delegate: OnboardingContentViewDelegate, itemsCount: Int, bottomConstant: CGFloat) -> OnboardingContentView {
    let contentView = Init(OnboardingContentView(itemsCount: itemsCount, delegate: delegate)) {
      $0.backgroundColor                           = .clearColor()
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    view.addSubview(contentView)

    // add constraints
    for attribute in [NSLayoutAttribute.Left, NSLayoutAttribute.Right, NSLayoutAttribute.Top] {
      (view, contentView) >>>- { $0.attribute = attribute }
    }
    (view, contentView) >>>- {
      $0.attribute = .Bottom
      $0.constant  = bottomConstant
    }
    return contentView
  }
}

// MARK: create

extension OnboardingContentView {

  private func commonInit() {

    currentItem = createItem(0)
  }

  private func createItem(index: Int) -> OnboardingContentViewItem {

    guard let info = delegate.onboardingItemAtIndex(index) else {
      return OnboardingContentViewItem.itemOnView(self)
    }

    let item = Init(OnboardingContentViewItem.itemOnView(self)) {
      $0.imageView?.image       = UIImage(named: info.imageName)
      $0.titleLabel?.text       = info.title
      $0.titleLabel?.font       = info.titleFont
      $0.titleLabel?.textColor  = info.titleColor
      $0.descriptionLabel?.text = info.description
      $0.descriptionLabel?.font = info.descriptionFont
      $0.descriptionLabel?.textColor = info.descriptionColor
        
      if let buttonTitle = info.actionButtonTitle where buttonTitle.isEmpty == false {
        $0.actionButton?.hidden = false
        $0.actionButton?.setTitle(buttonTitle, forState: .Normal)
        
        if let textColor = info.actionButtonTextColor {
            $0.actionButton?.titleLabel?.textColor = textColor
        }
        
        if let bgColor = info.actionButtonBackgroundColor {
            $0.actionButton?.backgroundColor = bgColor
        }
        
        $0.actionButton?.addTarget(self, action: #selector(OnboardingContentView.onActionButtonTapped(_:)), forControlEvents: .TouchUpInside)
        self.actionButtonHandlerCallback = info.actionButtonHandler
      }
      else {
        $0.actionButton?.hidden = true
        self.actionButtonHandlerCallback = nil
      }
    }
    
    delegate.onboardingConfigurationItem(item, index: index)
    return item
  }
}

// MARK: animations

extension OnboardingContentView {

  private func hideItemView(item: OnboardingContentViewItem?, duration: Double) {
    guard let item = item else {
      return
    }

    item.bottomConstraint?.constant -= Constants.dyOffsetAnimation
    item.centerConstraint?.constant *= 1.3

    UIView.animateWithDuration(duration,
                               delay: 0,
                               options: .CurveEaseOut, animations: {
      item.alpha = 0
      self.layoutIfNeeded()
    },
    completion: {success in
      item.removeFromSuperview()
    })
  }

  private func showItemView(item: OnboardingContentViewItem, duration: Double) {
    item.bottomConstraint?.constant = Constants.dyOffsetAnimation
    item.centerConstraint?.constant /= 2
    item.alpha = 0
    layoutIfNeeded()

    item.bottomConstraint?.constant = 0
    item.centerConstraint?.constant *= 2

    UIView.animateWithDuration(duration,
                               delay: 0,
                               options: .CurveEaseOut, animations: {
      item.alpha = 0
      item.alpha = 1
      self.layoutIfNeeded()
    }, completion: nil)
  }
}


// MARK: - Action Button:

extension OnboardingContentView {
    
    func onActionButtonTapped(button: UIButton) {
        self.actionButtonHandlerCallback?()
    }
    
}
