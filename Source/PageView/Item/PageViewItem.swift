//
//  PageViewItem.swift
//  AnimatedPageView
//
//  Created by Alex K. on 12/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class PageViewItem: UIView {

    let circleRadius: CGFloat
    let selectedCircleRadius: CGFloat
    let lineWidth: CGFloat
    let itemColor: UIColor

    var select: Bool

    var centerView: UIView?
    var imageView: UIImageView?
    var circleLayer: CAShapeLayer?
    var tickIndex: Int = 0

    init(radius: CGFloat, itemColor: UIColor, selectedRadius: CGFloat, lineWidth: CGFloat = 3, isSelect: Bool = false) {
        self.itemColor = itemColor
        self.lineWidth = lineWidth
        circleRadius = radius
        selectedCircleRadius = selectedRadius
        select = isSelect
        super.init(frame: CGRect.zero)
        commonInit()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: public

extension PageViewItem {

    func animationSelected(_ selected: Bool, duration: Double, fillColor: Bool) {
        let toAlpha: CGFloat = selected == true ? 1 : 0
        imageAlphaAnimation(toAlpha, duration: duration)

        let currentRadius = selected == true ? selectedCircleRadius : circleRadius
        let scaleAnimation = circleScaleAnimation(currentRadius - lineWidth / 2.0, duration: duration)
        let toColor = fillColor == true ? itemColor : UIColor.clear
        let colorAnimation = circleBackgroundAnimation(toColor, duration: duration)

        circleLayer?.add(scaleAnimation, forKey: nil)
        circleLayer?.add(colorAnimation, forKey: nil)
    }
}

// MARK: configuration

extension PageViewItem {

    fileprivate func commonInit() {
        centerView = createBorderView()
        imageView = createImageView()
    }

    fileprivate func createBorderView() -> UIView {
        let view = Init(UIView(frame: CGRect.zero)) {
            $0.backgroundColor = .blue
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        addSubview(view)

        // create circle layer
        let currentRadius = select == true ? selectedCircleRadius : circleRadius
        let circleLayer = createCircleLayer(currentRadius, lineWidth: lineWidth)
        view.layer.addSublayer(circleLayer)
        self.circleLayer = circleLayer

        // add constraints
        [NSLayoutConstraint.Attribute.centerX, NSLayoutConstraint.Attribute.centerY].forEach { attribute in
            (self, view) >>>- {
                $0.attribute = attribute
                return
            }
        }
        [NSLayoutConstraint.Attribute.height, NSLayoutConstraint.Attribute.width].forEach { attribute in
            view >>>- {
                $0.attribute = attribute
                return
            }
        }
        return view
    }

    fileprivate func createCircleLayer(_ radius: CGFloat, lineWidth: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius - lineWidth / 2.0, startAngle: 0, endAngle: CGFloat(2.0 * Double.pi), clockwise: true)
        let layer = Init(CAShapeLayer()) {
            $0.path = path.cgPath
            $0.lineWidth = lineWidth
            $0.strokeColor = itemColor.cgColor
            $0.fillColor = UIColor.clear.cgColor
        }
        return layer
    }

    fileprivate func createImageView() -> UIImageView {
        let imageView = Init(UIImageView(frame: CGRect.zero)) {
            $0.contentMode = .scaleAspectFit
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.alpha = select == true ? 1 : 0
        }
        addSubview(imageView)

        // add constraints
        [NSLayoutConstraint.Attribute.left, NSLayoutConstraint.Attribute.right, NSLayoutConstraint.Attribute.top, NSLayoutConstraint.Attribute.bottom].forEach { attribute in
            (self, imageView) >>>- { $0.attribute = attribute; return }
        }
        
        return imageView
    }
}

// MARK: animations

extension PageViewItem {

    fileprivate func circleScaleAnimation(_ toRadius: CGFloat, duration: Double) -> CABasicAnimation {
        let path = UIBezierPath(arcCenter: CGPoint.zero, radius: toRadius, startAngle: 0, endAngle: CGFloat(2.0 * Double.pi), clockwise: true)
        let animation = Init(CABasicAnimation(keyPath: "path")) {
            $0.duration = duration
            $0.toValue = path.cgPath
            $0.isRemovedOnCompletion = false
            $0.fillMode = .forwards
        }
        return animation
    }

    fileprivate func circleBackgroundAnimation(_ toColor: UIColor, duration: Double) -> CABasicAnimation {
        let animation = Init(CABasicAnimation(keyPath: "fillColor")) {
            $0.duration = duration
            $0.toValue = toColor.cgColor
            $0.isRemovedOnCompletion = false
            $0.fillMode = .forwards
            $0.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        }
        return animation
    }

    fileprivate func imageAlphaAnimation(_ toValue: CGFloat, duration: Double) {
        UIView.animate(withDuration: duration, delay: 0, animations: {
            self.imageView?.alpha = toValue
        }, completion: nil)
    }
}
