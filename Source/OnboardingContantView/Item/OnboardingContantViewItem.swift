//
//  OnboardingContentViewItem.swift
//  AnimatedPageView
//
//  Created by Alex K. on 21/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

 open class OnboardingContentViewItem: UIView {
  
  var bottomConstraint: NSLayoutConstraint?
  var centerConstraint: NSLayoutConstraint?
  
  open var imageView: UIImageView?
  open var imageSource: String?
  open var titleLabel: UILabel?
  open var descriptionLabel: UILabel?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
    //add notification for update image when fetched later
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.prepareImage(notification:)),
                                           name: NSNotification.Name(rawValue: "SH_PrepareImage"),
                                           object: nil)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: notification

extension OnboardingContentViewItem {
    @objc func prepareImage(notification: NSNotification) {
        if (self.imageView?.image == nil) //if already has image, not need to check
        {
            //there is a image source for this item
            if let sourceLength = self.imageSource?.lengthOfBytes(using: String.Encoding.utf8), sourceLength > 0 {
                let imageSource = notification.userInfo!["source"]
                //it's same image source, so set the image
                if (self.imageSource?.compare(imageSource as! String) == ComparisonResult.orderedSame)
                {
                    DispatchQueue.main.async {
                        self.imageView?.image = notification.userInfo!["image"] as? UIImage
                    }
                }
            }
        }
    }
}

// MARK: public

extension OnboardingContentViewItem {
  
  class func itemOnView(_ view: UIView) -> OnboardingContentViewItem {
    let item = Init(OnboardingContentViewItem(frame:CGRect.zero)) {
      $0.backgroundColor                           = .clear
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    view.addSubview(item)
    
    // add constraints
    item >>>- {
      $0.attribute = .height
      $0.constant  = 10000
      $0.relation  = .lessThanOrEqual
      return
    }

    for attribute in [NSLayoutAttribute.leading, NSLayoutAttribute.trailing] {
      (view, item) >>>- {
        $0.attribute = attribute
        return
      }
    }
    
    for attribute in [NSLayoutAttribute.centerX, NSLayoutAttribute.centerY] {
      (view, item) >>>- {
        $0.attribute = attribute
        return
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
      $0.attribute       = .top
      $0.secondAttribute = .bottom
      $0.constant        = 50
      return
    }
    (self, descriptionLabel, titleLabel) >>>- {
      $0.attribute       = .top
      $0.secondAttribute = .bottom
      $0.constant        = 10
      return
    }

    self.titleLabel       = titleLabel
    self.descriptionLabel = descriptionLabel
    self.imageView        = imageView
  }

  func createTitleLabel(_ onView: UIView) -> UILabel {
    let label = Init(createLabel()) {
      $0.font = UIFont(name: "Nunito-Bold" , size: 36)
    }
    onView.addSubview(label)
    
   // add constraints
    label >>>- {
      $0.attribute = .height
      $0.constant  = 10000
      $0.relation  = .lessThanOrEqual
      return
    }

    for attribute in [NSLayoutAttribute.centerX, NSLayoutAttribute.leading, NSLayoutAttribute.trailing] {
      (onView, label) >>>- {
        $0.attribute = attribute
        return
      }
    }
    return label
  }
  
  func createDescriptionLabel(_ onView: UIView) -> UILabel {
    let label = Init(createLabel()) {
      $0.font          = UIFont(name: "OpenSans-Regular" , size: 14)
      $0.numberOfLines = 0
    }
    onView.addSubview(label)
    
    // add constraints
    label >>>- {
      $0.attribute = .height
      $0.constant  = 10000
      $0.relation  = .lessThanOrEqual
      return
    }

    for (attribute, constant) in [(NSLayoutAttribute.leading, 30), (NSLayoutAttribute.trailing, -30)] {
      (onView, label) >>>- {
        $0.attribute = attribute
        $0.constant  = CGFloat(constant)
        return
      }
    }

    (onView, label) >>>- { $0.attribute = .centerX; return }
    bottomConstraint = (onView, label) >>>- { $0.attribute = .bottom; return }

    return label
  }

  func createLabel() -> UILabel {
    return Init(UILabel(frame: CGRect.zero)) {
      $0.backgroundColor                           = .clear
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.textAlignment                             = .center
      $0.textColor                                 = .white
    }
  }

  func createImage(_ onView: UIView) -> UIImageView {
    let imageView = Init(UIImageView(frame: CGRect.zero)) {
      $0.contentMode                               = .scaleAspectFit
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    onView.addSubview(imageView)
    
    // add constratints
    for attribute in [NSLayoutAttribute.width, NSLayoutAttribute.height] {
      imageView >>>- {
        $0.attribute = attribute
        $0.constant  = 188
        return
      }
    }
    
    for attribute in [NSLayoutAttribute.centerX, NSLayoutAttribute.top] {
      (onView, imageView) >>>- { $0.attribute = attribute; return }
    }
    
    return imageView
  }
}
