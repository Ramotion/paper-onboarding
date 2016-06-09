//
//  OnboardingContentViewItem.swift
//  AnimatedPageView
//
//  Created by Alex K. on 21/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

 public class OnboardingContentViewItem: UIView {
  
  var bottomConstraint: NSLayoutConstraint?
  var centerConstraint: NSLayoutConstraint?
  
  public var imageView: UIImageView?
  public var titleLabel: UILabel?
  public var descriptionLabel: UILabel?
  public var actionButton: UIButton?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: public

extension OnboardingContentViewItem {
  
  class func itemOnView(view: UIView) -> OnboardingContentViewItem {
    let item = Init(OnboardingContentViewItem(frame:CGRect.zero)) {
      $0.backgroundColor                           = .clearColor()
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    view.addSubview(item)
    
    // add constraints
    item >>>- {
      $0.attribute = .Height
      $0.constant  = 10000
      $0.relation  = .LessThanOrEqual
    }
    
    for attribute in [NSLayoutAttribute.Leading, NSLayoutAttribute.Trailing] {
      (view, item) >>>- {
        $0.attribute = attribute
      }
    }
    
    for attribute in [NSLayoutAttribute.CenterX, NSLayoutAttribute.CenterY] {
      (view, item) >>>- {
        $0.attribute = attribute
      }
    }
    
   return item
  }
    
  func getActionButtonFrame() -> CGRect? {
    guard let sv = self.superview, let actionButtonFrame = actionButton?.frame else {
        return nil
    }
    
    let convertedRect = self.convertRect(actionButtonFrame, toView: sv)
    return convertedRect
  }
    
}

// MARK: create

private extension OnboardingContentViewItem {
  
  func commonInit() {
    
    let titleLabel       = createTitleLabel(self)
    let descriptionLabel = createDescriptionLabel(self)
    let imageView        = createImage(self)
    let actionButton     = createActionButton(self)

    // added constraints
    centerConstraint = (self, titleLabel, imageView) >>>- {
      $0.attribute       = .Top
      $0.secondAttribute = .Bottom
      $0.constant        = 50
    }
    
    (self, descriptionLabel, titleLabel) >>>- {
      $0.attribute       = .Top
      $0.secondAttribute = .Bottom
      $0.constant        = 10
    }
    
    (self, actionButton, self) >>>- {
      $0.attribute       = .Top
      $0.secondAttribute = .Bottom
      $0.constant        = 80
    }
    
    self.titleLabel       = titleLabel
    self.descriptionLabel = descriptionLabel
    self.imageView        = imageView
    self.actionButton     = actionButton
  }

  func createTitleLabel(onView: UIView) -> UILabel {
    let label = Init(createLabel()) {
      $0.font = UIFont(name: "Nunito-Bold" , size: 36)
    }
    onView.addSubview(label)
    
   // add constraints
    label >>>- {
      $0.attribute = .Height
      $0.constant  = 10000
      $0.relation  = .LessThanOrEqual
    }
  
    for attribute in [NSLayoutAttribute.CenterX, NSLayoutAttribute.Leading, NSLayoutAttribute.Trailing] {
      (onView, label) >>>- {
        $0.attribute = attribute
      }
    }
    return label
  }
  
  func createDescriptionLabel(onView: UIView) -> UILabel {
    let label = Init(createLabel()) {
      $0.font          = UIFont(name: "OpenSans-Regular" , size: 14)
      $0.numberOfLines = 0
    }
    onView.addSubview(label)
    
    // add constraints
    label >>>- {
      $0.attribute = .Height
      $0.constant  = 10000
      $0.relation  = .LessThanOrEqual
    }
  
    for (attribute, constant) in [(NSLayoutAttribute.Leading, 30), (NSLayoutAttribute.Trailing, -30)] {
      (onView, label) >>>- {
        $0.attribute = attribute
        $0.constant  = CGFloat(constant)
      }
    }
      (onView, label) >>>- { $0.attribute = .CenterX }
      bottomConstraint = (onView, label) >>>- { $0.attribute = .Bottom }
    
    return label
  }

  func createLabel() -> UILabel {
    return Init(UILabel(frame: CGRect.zero)) {
      $0.backgroundColor                           = .clearColor()
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.textAlignment                             = .Center
      $0.textColor                                 = .whiteColor()
    }
  }

  func createImage(onView: UIView) -> UIImageView {
    let imageView = Init(UIImageView(frame: CGRect.zero)) {
      $0.contentMode                               = .ScaleAspectFit
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    onView.addSubview(imageView)
    
    // add constratints
    for attribute in [NSLayoutAttribute.Width, NSLayoutAttribute.Height] {
      imageView >>>- {
        $0.attribute = attribute
        $0.constant  = 188
      }
    }
    
    for attribute in [NSLayoutAttribute.CenterX, NSLayoutAttribute.Top] {
      (onView, imageView) >>>- { $0.attribute = attribute }
    }
    
    return imageView
  }
    
  func createActionButton(onView: UIView) -> UIButton {
    let button = Init(UIButton(frame: CGRect.zero)) {
        $0.backgroundColor = .clearColor()
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.textAlignment = .Center
        $0.titleLabel?.textColor = .whiteColor()
        $0.titleLabel?.font = .systemFontOfSize(20)
        $0.titleLabel?.adjustsFontSizeToFitWidth = true
        $0.titleLabel?.minimumScaleFactor = 0.5
        $0.layer.cornerRadius = 6
    }
    
    onView.addSubview(button)
    
    button >>>- {
        $0.attribute = .Height
        $0.constant = 60
    }
    
    for (attribute, constant) in [(NSLayoutAttribute.Leading, 30), (NSLayoutAttribute.Trailing, -30), (NSLayoutAttribute.CenterX, 0)] {
        (onView, button) >>>- {
            $0.attribute = attribute
            $0.constant = CGFloat(constant)
        }
    }
    
    return button
  }
}