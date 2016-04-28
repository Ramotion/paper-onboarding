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
  let borderColor: UIColor
  
  var select: Bool
  
  var centerView: UIView?
  var imageView: UIImageView?
  var circleLayer: CAShapeLayer?
  var tickIndex: Int = 0
  
  init(radius: CGFloat, selectedRadius: CGFloat, borderColor: UIColor = .whiteColor(), lineWidth: CGFloat = 3, isSelect: Bool = false) {
    self.borderColor = borderColor
    self.lineWidth = lineWidth
    self.circleRadius = radius
    self.selectedCircleRadius = selectedRadius
    self.select = isSelect
    super.init(frame: CGRect.zero)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: public

extension PageViewItem {
  
  func animationSelected(selected: Bool, duration: Double, fillColor: Bool) {
    let toAlpha: CGFloat = selected == true ? 1 : 0
    imageAlphaAnimation(toAlpha, duration: duration)
    
    let currentRadius  = selected == true ? selectedCircleRadius : circleRadius
    let scaleAnimation = circleScaleAnimation(currentRadius - lineWidth / 2.0, duration: duration)
    let toColor        = fillColor == true ? UIColor.whiteColor() : UIColor.clearColor()
    let colorAnimation = circleBackgroundAnimation(toColor, duration: duration)
    
    circleLayer?.addAnimation(scaleAnimation, forKey: nil)
    circleLayer?.addAnimation(colorAnimation, forKey: nil)
  }
}

// MARK: configuration

extension PageViewItem {
  
  private func commonInit() {
    centerView = createBorderView()
    imageView  = createImageView()
  }
  
  private func createBorderView() -> UIView {
    let view = Init(UIView(frame:CGRect.zero)) {
      $0.backgroundColor                           = .blueColor()
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    addSubview(view)
    
    // create circle layer
    let currentRadius = select == true ? selectedCircleRadius : circleRadius
    let circleLayer   = createCircleLayer(currentRadius, lineWidth: lineWidth)
    view.layer.addSublayer(circleLayer)
    self.circleLayer = circleLayer
    
    // add constraints
    [NSLayoutAttribute.CenterX, NSLayoutAttribute.CenterY].forEach { attribute in
        (self , view) >>>- {
          $0.attribute = attribute
      }
    }
    [NSLayoutAttribute.Height, NSLayoutAttribute.Width].forEach { attribute in
        view >>>- {
          $0.attribute = attribute
      }
    }
    return view
  }
  
  private func createCircleLayer(radius: CGFloat, lineWidth: CGFloat) -> CAShapeLayer {
    let path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius - lineWidth / 2.0, startAngle: 0, endAngle: CGFloat(2.0 * M_PI), clockwise: true)
    let layer = Init(CAShapeLayer()) {
      $0.path        = path.CGPath
      $0.lineWidth   = lineWidth
      $0.strokeColor = UIColor.whiteColor().CGColor
      $0.fillColor   = UIColor.clearColor().CGColor
    }
    return layer
  }

  private func createImageView() -> UIImageView {
    let imageView = Init(UIImageView(frame: CGRect.zero)) {
      $0.contentMode                               = .ScaleAspectFit
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.alpha                                     = select == true ? 1 : 0
    }
    addSubview(imageView)
    
     // add constraints
    [NSLayoutAttribute.Left, NSLayoutAttribute.Right, NSLayoutAttribute.Top, NSLayoutAttribute.Bottom].forEach { attribute in
        (self , imageView) >>>- { $0.attribute = attribute }
    }
    return imageView
  }
}

// MARK: animations

extension PageViewItem {
  
  private func circleScaleAnimation(toRadius: CGFloat, duration: Double) -> CABasicAnimation {
    let path = UIBezierPath(arcCenter: CGPoint.zero, radius: toRadius, startAngle: 0, endAngle: CGFloat(2.0 * M_PI), clockwise: true)
    let animation = Init(CABasicAnimation(keyPath: "path")) {
      $0.duration            = duration
      $0.toValue             = path.CGPath
      $0.removedOnCompletion = false
      $0.fillMode            = kCAFillModeForwards
    }
    return animation
  }

  private func circleBackgroundAnimation(toColor: UIColor, duration: Double) -> CABasicAnimation {
    let animation = Init(CABasicAnimation(keyPath: "fillColor")) {
      $0.duration            = duration
      $0.toValue             = toColor.CGColor
      $0.removedOnCompletion = false
      $0.fillMode            = kCAFillModeForwards
      $0.timingFunction      = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    }
    return animation
  }
  
  private func imageAlphaAnimation(toValue: CGFloat, duration: Double) {
    UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations: { 
      self.imageView?.alpha = toValue
    }, completion: nil)
  }

}