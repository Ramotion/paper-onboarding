//
//  PageView.swift
//  AnimatedPageView
//
//  Created by Alex K. on 13/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class PageView: UIView {

    var itemsCount = 3
    var itemRadius: CGFloat = 8.0
    var selectedItemRadius: CGFloat = 22.0
    var duration: Double = 0.7
    var space: CGFloat = 20 // space between items
    let itemColor: (Int) -> UIColor

    // configure items set image or chage color for border view
    var configuration: ((_ item: PageViewItem, _ index: Int) -> Void)? {
        didSet {
            configurePageItems(containerView?.items)
        }
    }

    fileprivate var containerX: NSLayoutConstraint?
    var containerView: PageContrainer?

    init(frame: CGRect, itemsCount: Int, radius: CGFloat, selectedRadius: CGFloat, itemColor: @escaping (Int) -> UIColor) {
        self.itemsCount = itemsCount
        itemRadius = radius
        selectedItemRadius = selectedRadius
        self.itemColor = itemColor
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func hitTest(_ point: CGPoint, with _: UIEvent?) -> UIView? {
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

    class func pageViewOnView(_ view: UIView, itemsCount: Int, bottomConstant: CGFloat, radius: CGFloat, selectedRadius: CGFloat, itemColor: @escaping (Int) -> UIColor) -> PageView {
        let pageView = PageView(frame: CGRect.zero,
                                itemsCount: itemsCount,
                                radius: radius,
                                selectedRadius: selectedRadius,
                                itemColor: itemColor)
        pageView.translatesAutoresizingMaskIntoConstraints = false
        pageView.alpha = 0.4
        view.addSubview(pageView)

      let layoutAttribs:[(NSLayoutConstraint.Attribute, Int)] =  [(NSLayoutConstraint.Attribute.left, 0), (NSLayoutConstraint.Attribute.right, 0), (NSLayoutConstraint.Attribute.bottom, Int(bottomConstant))]
      
        // add constraints
      for (attribute, const) in layoutAttribs {
            (view, pageView) >>>- {
                $0.constant = CGFloat(const)
                $0.attribute = attribute
                return
            }
        }
        pageView >>>- {
            $0.attribute = .height
            $0.constant = 30
            return
        }

        return pageView
    }

    func currentIndex(_ index: Int, animated: Bool) {

        if 0 ..< itemsCount ~= index {
            containerView?.currenteIndex(index, duration: duration * 0.5, animated: animated)
            moveContainerTo(index, animated: animated, duration: duration)
        }
    }

    func positionItemIndex(_ index: Int, onView: UIView) -> CGPoint? {
        if 0 ..< itemsCount ~= index {
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
        backgroundColor = .clear
    }
}

// MARK: create

extension PageView {

    fileprivate func createContainerView() -> PageContrainer {
        let pageControl = PageContrainer(radius: itemRadius,
                                         selectedRadius: selectedItemRadius,
                                         space: space,
                                         itemsCount: itemsCount,
                                         itemColor: itemColor)
        let container = Init(pageControl) {
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        addSubview(container)

        // add constraints
        for attribute in [NSLayoutConstraint.Attribute.top, NSLayoutConstraint.Attribute.bottom] {
            (self, container) >>>- { $0.attribute = attribute; return }
        }

        containerX = (self, container) >>>- { $0.attribute = .centerX; return }

        container >>>- {
            $0.attribute = .width
            $0.constant = selectedItemRadius * 2 + CGFloat(itemsCount - 1) * (itemRadius * 2) + space * CGFloat(itemsCount - 1)
            return
        }
        return container
    }

    fileprivate func configurePageItems(_ items: [PageViewItem]?) {
        guard let items = items else {
            return
        }
        for index in 0 ..< items.count {
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

        let containerWidth = CGFloat(itemsCount + 1) * selectedItemRadius + space * CGFloat(itemsCount - 1)
        let toValue = containerWidth / 2.0 - selectedItemRadius - (selectedItemRadius + space) * CGFloat(index)
        containerX.constant = toValue

        if animated == true {
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: UIView.AnimationOptions(),
                           animations: {
                               self.layoutIfNeeded()
                           },
                           completion: nil)
        } else {
            layoutIfNeeded()
        }
    }
}
