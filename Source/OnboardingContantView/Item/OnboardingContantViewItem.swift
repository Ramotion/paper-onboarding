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
    open var titleLabel: UILabel?
    open var descriptionLabel: UILabel?
    open var actionButton: UIButton?

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

    class func itemOnView(_ view: UIView) -> OnboardingContentViewItem {
        let item = Init(OnboardingContentViewItem(frame: CGRect.zero)) {
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        view.addSubview(item)

        // add constraints
        item >>>- {
            $0.attribute = .height
            $0.constant = 10000
            $0.relation = .lessThanOrEqual
            return
        }

        for attribute in [NSLayoutAttribute.leading, NSLayoutAttribute.trailing] {
            (view, item) >>>- {
                $0.attribute = attribute
                return
            }
        }

        for attribute in [NSLayoutAttribute.centerX] {
            (view, item) >>>- {
                $0.attribute = attribute
                return
            }
        }
        for attribute in [NSLayoutAttribute.top] {
            (view, item) >>>- {
                $0.attribute = attribute
                $0.constant = 40
            }
        }

        return item
    }

    func getActionButtonFrame() -> CGRect? {
        guard let sv = self.superview, let actionButtonFrame = actionButton?.frame else {
            return nil
        }

        let convertedRect = self.convert(actionButtonFrame, to: sv)
        return convertedRect
    }

}

// MARK: create

private extension OnboardingContentViewItem {

    func commonInit() {

        let titleLabel = createTitleLabel(self)
        let descriptionLabel = createDescriptionLabel(self)
        let imageView = createImage(self)
        let actionButton = createActionButton(onView: self)

        let viewHeight = UIScreen.main.bounds.size.height
        let iPhone6SHeight: CGFloat = 736
        let iPhone5Height: CGFloat = 568

        let minTitleOffsetY: CGFloat = 15
        let maxTitleOffsetY: CGFloat = 50

        let titleOffsetY = CGFloat(Int(minTitleOffsetY + (((viewHeight - iPhone5Height) / (iPhone6SHeight - iPhone5Height)) * (maxTitleOffsetY - minTitleOffsetY))))

        // added constraints
        centerConstraint = (self, titleLabel, imageView) >>>- {
            $0.attribute = .top
            $0.secondAttribute = .bottom
            $0.constant = titleOffsetY
            return
        }
        (self, descriptionLabel, titleLabel) >>>- {
            $0.attribute = .top
            $0.secondAttribute = .bottom
            $0.constant = 10
            return
        }

        let minButtonOffsetY: CGFloat = 40
        let maxButtonOffsetY: CGFloat = 70

        let buttonOffsetY = CGFloat(Int(minButtonOffsetY + (((viewHeight - iPhone5Height) / (iPhone6SHeight - iPhone5Height)) * (maxButtonOffsetY - minButtonOffsetY))))

        (self, actionButton, self) >>>- {
            $0.attribute = .top
            $0.secondAttribute = .bottom
            $0.constant = buttonOffsetY
        }

        self.titleLabel = titleLabel
        self.descriptionLabel = descriptionLabel
        self.imageView = imageView
        self.actionButton = actionButton
    }

    func createTitleLabel(_ onView: UIView) -> UILabel {
        let label = Init(createLabel()) {
            $0.font = UIFont(name: "Nunito-Bold", size: 36)
        }
        onView.addSubview(label)

        // add constraints
        label >>>- {
            $0.attribute = .height
            $0.constant = 10000
            $0.relation = .lessThanOrEqual
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
            $0.font = UIFont(name: "OpenSans-Regular", size: 14)
            $0.numberOfLines = 0
        }
        onView.addSubview(label)

        // add constraints
        label >>>- {
            $0.attribute = .height
            $0.constant = 10000
            $0.relation = .lessThanOrEqual
            return
        }

        for (attribute, constant) in [(NSLayoutAttribute.leading, 30), (NSLayoutAttribute.trailing, -30)] {
            (onView, label) >>>- {
                $0.attribute = attribute
                $0.constant = CGFloat(constant)
                return
            }
        }

        (onView, label) >>>- {
            $0.attribute = .centerX;
            return
        }
        bottomConstraint = (onView, label) >>>- {
            $0.attribute = .bottom;
            return
        }

        return label
    }

    func createLabel() -> UILabel {
        return Init(UILabel(frame: CGRect.zero)) {
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textAlignment = .center
            $0.textColor = .white
        }
    }

    func createImage(_ onView: UIView) -> UIImageView {
        let viewHeight = UIScreen.main.bounds.size.height
        let iPhone6SHeight: CGFloat = 736
        let iPhone5Height: CGFloat = 568

        let minImageHeight: CGFloat = 188
        let maxImageHeight: CGFloat = 250

        let imageHeight = CGFloat(Int(minImageHeight + (((viewHeight - iPhone5Height) / (iPhone6SHeight - iPhone5Height)) * (maxImageHeight - minImageHeight))))

        let imageView = Init(UIImageView(frame: CGRect.zero)) {
            $0.contentMode = .scaleAspectFit
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        onView.addSubview(imageView)

        // add constratints
        for attribute in [NSLayoutAttribute.width, NSLayoutAttribute.height] {
            imageView >>>- {
                $0.attribute = attribute
                $0.constant = imageHeight
                return
            }
        }

        (onView, imageView) >>>- {
            $0.attribute = .centerX
            return
        }


        let minImageOffsetY: CGFloat = 0
        let maxImageOffsetY: CGFloat = 50

        let imageOffsetY = CGFloat(Int(minImageOffsetY + (((viewHeight - iPhone5Height) / (iPhone6SHeight - iPhone5Height)) * (maxImageOffsetY - minImageOffsetY))))

        (onView, imageView) >>>- {
            $0.attribute = .top
            $0.constant = imageOffsetY
        }

        return imageView
    }

    func createActionButton(onView: UIView) -> UIButton {
        let button = Init(UIButton(frame: CGRect.zero)) {
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.titleLabel?.textAlignment = .center
            $0.titleLabel?.textColor = .white
            $0.titleLabel?.font = .systemFont(ofSize: 20)
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
            $0.titleLabel?.minimumScaleFactor = 0.5
            $0.layer.cornerRadius = 6
        }

        onView.addSubview(button)

        let viewHeight = UIScreen.main.bounds.size.height
        let iPhone6SHeight: CGFloat = 736
        let iPhone5Height: CGFloat = 568

        let minButtonHeight: CGFloat = 45
        let maxButtonHeight: CGFloat = 60

        let buttonHeight = CGFloat(Int(minButtonHeight + (((viewHeight - iPhone5Height) / (iPhone6SHeight - iPhone5Height)) * (maxButtonHeight - minButtonHeight))))

        button >>>- {
            $0.attribute = .height
            $0.constant = buttonHeight
        }

        for (attribute, constant) in [(NSLayoutAttribute.leading, 30), (NSLayoutAttribute.trailing, -30), (NSLayoutAttribute.centerX, 0)] {
            (onView, button) >>>- {
                $0.attribute = attribute
                $0.constant = CGFloat(constant)
            }
        }

        return button
    }
}
