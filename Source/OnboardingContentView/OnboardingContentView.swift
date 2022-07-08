//
//  OnboardingContentView.swift
//  AnimatedPageView
//
//  Created by Alex K. on 21/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

protocol OnboardingContentViewDelegate: class {

    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo?
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int)
}

class OnboardingContentView: UIView {

    fileprivate struct Constants {
        static let dyOffsetAnimation: CGFloat = 110
        static let showDuration: Double = 0.8
        static let hideDuration: Double = 0.2
    }

    fileprivate var currentItem: OnboardingContentViewItem?
    weak var delegate: OnboardingContentViewDelegate?

    init(itemsCount _: Int, delegate: OnboardingContentViewDelegate) {
        self.delegate = delegate
        super.init(frame: CGRect.zero)

        commonInit()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: public

extension OnboardingContentView {

    func currentItem(_ index: Int, animated _: Bool) {

        let showItem = createItem(index)
        showItemView(showItem, duration: Constants.showDuration)

        hideItemView(currentItem, duration: Constants.hideDuration)

        currentItem = showItem
    }
}

// MARK: life cicle

extension OnboardingContentView {

    class func contentViewOnView(_ view: UIView, delegate: OnboardingContentViewDelegate, itemsCount: Int, bottomConstant: CGFloat) -> OnboardingContentView {
        let contentView = Init(OnboardingContentView(itemsCount: itemsCount, delegate: delegate)) {
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        view.addSubview(contentView)

        // add constraints
        for attribute in [NSLayoutConstraint.Attribute.left, NSLayoutConstraint.Attribute.right, NSLayoutConstraint.Attribute.top] {
            (view, contentView) >>>- { $0.attribute = attribute; return }
        }
        (view, contentView) >>>- {
            $0.attribute = .bottom
            $0.constant = bottomConstant
            return
        }
        return contentView
    }
}

// MARK: create

extension OnboardingContentView {

    fileprivate func commonInit() {

        currentItem = createItem(0)
    }

    fileprivate func createItem(_ index: Int) -> OnboardingContentViewItem {

        guard let info = delegate?.onboardingItemAtIndex(index) else {
            return OnboardingContentViewItem.itemOnView(self, titlePadding: 0, descriptionPadding: 0)
        }

        let item = Init(OnboardingContentViewItem.itemOnView(self, titlePadding: info.titleLabelPadding, descriptionPadding: info.descriptionLabelPadding)) {
            $0.imageView?.image = info.informationImage
            $0.titleLabel?.text = info.title
            $0.titleLabel?.font = info.titleFont
            $0.titleLabel?.textColor = info.titleColor
            $0.descriptionLabel?.text = info.description
            $0.descriptionLabel?.font = info.descriptionFont
            $0.descriptionLabel?.textColor = info.descriptionColor
        }

        delegate?.onboardingConfigurationItem(item, index: index)
        return item
    }
}

// MARK: animations

extension OnboardingContentView {

    fileprivate func hideItemView(_ item: OnboardingContentViewItem?, duration: Double) {
        guard let item = item else {
            return
        }

        item.descriptionBottomConstraint?.constant -= Constants.dyOffsetAnimation
        item.titleCenterConstraint?.constant *= 1.3

        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseOut, animations: {
                           item.alpha = 0
                           self.layoutIfNeeded()
                       },
                       completion: { _ in
                           item.removeFromSuperview()
        })
    }

    fileprivate func showItemView(_ item: OnboardingContentViewItem, duration: Double) {
        item.descriptionBottomConstraint?.constant = Constants.dyOffsetAnimation
        item.titleCenterConstraint?.constant /= 2
        item.alpha = 0
        layoutIfNeeded()

        item.descriptionBottomConstraint?.constant = 0
        item.titleCenterConstraint?.constant *= 2

        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseOut, animations: {
                           item.alpha = 0
                           item.alpha = 1
                           self.layoutIfNeeded()
        }, completion: nil)
    }
}
