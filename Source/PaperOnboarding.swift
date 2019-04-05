//
//  PaperOnboarding.swift
//  AnimatedPageView
//
//  Created by Alex K. on 20/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

public struct OnboardingItemInfo {
    public let informationImage: UIImage
    public let title: String
    public let description: String
    public let pageIcon: UIImage
    public let color: UIColor
    public let titleColor: UIColor
    public let descriptionColor: UIColor
    public let titleFont: UIFont
    public let descriptionFont: UIFont
    public let descriptionLabelPadding: CGFloat
    public let titleLabelPadding: CGFloat
    
    public init (informationImage: UIImage, title: String, description: String, pageIcon: UIImage, color: UIColor, titleColor: UIColor, descriptionColor: UIColor, titleFont: UIFont, descriptionFont: UIFont, descriptionLabelPadding: CGFloat = 0, titleLabelPadding: CGFloat = 0) {
        self.informationImage = informationImage
        self.title = title
        self.description = description
        self.pageIcon = pageIcon
        self.color = color
        self.titleColor = titleColor
        self.descriptionColor = descriptionColor
        self.titleFont = titleFont
        self.descriptionFont = descriptionFont
        self.descriptionLabelPadding = descriptionLabelPadding
        self.titleLabelPadding = titleLabelPadding
    }
}

/// An instance of PaperOnboarding which display collection of information.
open class PaperOnboarding: UIView {

    ///  The object that acts as the data source of the  PaperOnboardingDataSource.
    @IBOutlet weak open var dataSource: AnyObject? {
        didSet {
            commonInit()
        }
    }

    /// The object that acts as the delegate of the PaperOnboarding. PaperOnboardingDelegate protocol
    @IBOutlet weak open var delegate: AnyObject?

    /// current index item
    open fileprivate(set) var currentIndex: Int = 0
    fileprivate(set) var itemsCount: Int = 0

    fileprivate var itemsInfo: [OnboardingItemInfo]?

    fileprivate let pageViewBottomConstant: CGFloat
    fileprivate var pageViewSelectedRadius: CGFloat = 22
    fileprivate var pageViewRadius: CGFloat = 8

    fileprivate var fillAnimationView: FillAnimationView?
    fileprivate var pageView: PageView?
    public fileprivate(set) var gestureControl: GestureControl?
    fileprivate var contentView: OnboardingContentView?
    
    public init(pageViewBottomConstant: CGFloat = 32) {
        
        self.pageViewBottomConstant = pageViewBottomConstant

        super.init(frame: CGRect.zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        self.pageViewBottomConstant = 32
        self.pageViewSelectedRadius = 22
        self.pageViewRadius = 8
        
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
            (delegate as? PaperOnboardingDelegate)?.onboardingWillTransitonToIndex(index)
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
        } else if index >= itemsCount {
            (delegate as? PaperOnboardingDelegate)?.onboardingWillTransitonToLeaving()
        }
    }
}

// MARK: create

extension PaperOnboarding {

    fileprivate func commonInit() {
        if case let dataSource as PaperOnboardingDataSource = dataSource {
            itemsCount = dataSource.onboardingItemsCount()
        }
        if case let dataSource as PaperOnboardingDataSource = dataSource {
            pageViewRadius = dataSource.onboardinPageItemRadius()
        }
        if case let dataSource as PaperOnboardingDataSource = dataSource {
            pageViewSelectedRadius = dataSource.onboardingPageItemSelectedRadius()
        }
        itemsInfo = createItemsInfo()
        translatesAutoresizingMaskIntoConstraints = false
        fillAnimationView = FillAnimationView.animationViewOnView(self, color: backgroundColor(currentIndex))
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
            (delegate as? PaperOnboardingDelegate)?.enableTapsOnPageControl == true,
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
        let pageView = PageView.pageViewOnView(
            self,
            itemsCount: itemsCount,
            bottomConstant: pageViewBottomConstant * -1,
            radius: pageViewRadius,
            selectedRadius: pageViewSelectedRadius,
            itemColor: { [weak self] in
                guard let dataSource = self?.dataSource as? PaperOnboardingDataSource else { return .white }
                return dataSource.onboardingPageItemColor(at: $0)
        })

        pageView.configuration = { [weak self] item, index in
            item.imageView?.image = self?.itemsInfo?[index].pageIcon
        }

        return pageView
    }

    fileprivate func createItemsInfo() -> [OnboardingItemInfo] {
        guard case let dataSource as PaperOnboardingDataSource = self.dataSource else {
            fatalError("set dataSource")
        }

        var items = [OnboardingItemInfo]()
        for index in 0 ..< itemsCount {
            let info = dataSource.onboardingItem(at: index)
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

    func gestureControlDidSwipe(_ direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case UISwipeGestureRecognizer.Direction.right:
            currentIndex(currentIndex - 1, animated: true)
        case UISwipeGestureRecognizer.Direction.left:
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

    @objc func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        (delegate as? PaperOnboardingDelegate)?.onboardingConfigurationItem(item, index: index)
    }
}
