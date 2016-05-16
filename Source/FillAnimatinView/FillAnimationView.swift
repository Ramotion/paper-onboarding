//
//  FillAnimationView.swift
//  FillanimationTest
//
//  Created by Alex K. on 20/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class FillAnimationView: UIView {

  private struct Constant {
    static let path   = "path"
    static let circle = "circle"
  }
}

// MARK: public

extension FillAnimationView {
  
  class func animavtionViewOnView(view: UIView, color: UIColor) -> FillAnimationView {
    let animationView = Init(FillAnimationView(frame: CGRect.zero)) {
      $0.backgroundColor                           = color
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    view.addSubview(animationView)
    
    // add constraints 
    for attribute in [NSLayoutAttribute.Left, NSLayoutAttribute.Right, NSLayoutAttribute.Top, NSLayoutAttribute.Bottom] {
      (view, animationView) >>>- { $0.attribute = attribute }
    }
    
    return animationView
  }

  func fillAnimation(color: UIColor, centerPosition: CGPoint, duration: Double) {
    
    let radius = max(bounds.size.width, bounds.size.height) * 1.5
    let circle = createCircleLayer(centerPosition, color: color)
    
    let animation = animationToRadius(radius, center: centerPosition, duration: duration)
    animation.setValue(circle, forKey: Constant.circle)
    circle.addAnimation(animation, forKey: nil)
  }
}

// MARK: create

extension FillAnimationView {
  
  private func createCircleLayer(position: CGPoint, color: UIColor) -> CAShapeLayer {
    let path = UIBezierPath(arcCenter: position, radius: 1, startAngle: 0, endAngle: CGFloat(2.0 * M_PI), clockwise: true)
    let layer = Init(CAShapeLayer()) {
      $0.path            = path.CGPath
      $0.fillColor       = color.CGColor
      $0.shouldRasterize = true
    }
    
    self.layer.addSublayer(layer)
    return layer
  }
}

// MARK: animation

extension FillAnimationView {
  
  private func animationToRadius(radius: CGFloat, center: CGPoint, duration: Double) -> CABasicAnimation {
    let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(2.0 * M_PI), clockwise: true)
    let animation = Init(CABasicAnimation(keyPath: Constant.path)) {
      $0.duration            = duration
      $0.toValue             = path.CGPath
      $0.removedOnCompletion = false
      $0.fillMode            = kCAFillModeForwards
      $0.delegate            = self
      $0.timingFunction      = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    }
    return animation
  }
  
  // animation delegate
  
  override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    
    guard let circleLayer = anim.valueForKey(Constant.circle) as? CAShapeLayer else {
      return
    }
    layer.backgroundColor = circleLayer.fillColor
    circleLayer.removeFromSuperlayer()
  }
}