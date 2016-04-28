//
//  OnboardingContentViewItem.swift
//  AnimatedPageView
//
//  Created by Alex K. on 21/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class OnboardingContentViewItem: UIView {
  
  var bottomConstraint: NSLayoutConstraint?
  var centerConstraint: NSLayoutConstraint?
  
  var imageView: UIImageView?
  var titleLabel: UILabel?
  var descriptionLabel: UILabel?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
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
}

// MARK: create

private extension OnboardingContentViewItem {
  
  func commonInit() {
    
    let titleLabel       = createTitleLabel(self)
    let descriptionLabel = createDescriptionLabel(self)
    let imageView        = createImage(self)

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
    
    self.titleLabel       = titleLabel
    self.descriptionLabel = descriptionLabel
    self.imageView        = imageView
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
}