//
//  PageViewItem.swift
//  AnimatedPageView
//
//  Created by Alex K. on 12/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

public class PageViewItem: UIView {
  
  let circleRadius: CGFloat
  let selectedCircleRadius: CGFloat
  let lineWidth: CGFloat
  let borderColor: UIColor
  
  var select: Bool
  
  public var borderView: UIView?
  public var imageView: UIImageView?
  var tickIndex: Int = 0
  
  public init(radius: CGFloat, selectedRadius: CGFloat, borderColor: UIColor = .whiteColor(), lineWidth: CGFloat = 3, isSelect: Bool = false) {
    self.borderColor = borderColor
    self.lineWidth = lineWidth
    self.circleRadius = radius
    self.selectedCircleRadius = selectedRadius
    self.select = isSelect
    super.init(frame: CGRect.zero)
    commonInit()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: configuration

extension PageViewItem {
  
  private func commonInit() {
    borderView = createBorderView()
    imageView = createImageView()
  }
  
  private func createBorderView() -> UIView {
    let view = Init(UIView(frame:CGRect.zero)) {
      $0.backgroundColor = .clearColor()
      $0.layer.borderColor = UIColor.whiteColor().CGColor
      $0.layer.borderWidth = 3
      $0.layer.cornerRadius = select == true ? selectedCircleRadius : circleRadius
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    addSubview(view)
    
    // add constraints
    [NSLayoutAttribute.Left, NSLayoutAttribute.Right, NSLayoutAttribute.Top, NSLayoutAttribute.Bottom].forEach { attribute in
        (self , view) >>>- { $0.attribute = attribute }
    }
    
    return view
  }
  
  private func createImageView() -> UIImageView {
    let imageView = Init(UIImageView(frame: CGRect.zero)) {
      $0.contentMode = .ScaleAspectFit
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.alpha = select == true ? 1 : 0
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

extension PageViewItem: Animatable {
  
  func animationTick(dt: Double, inout finished: Bool) {
    
    guard let borderView = self.borderView else {
      return
    }
    
    let toValue = select == true ? selectedCircleRadius * 2.0 : circleRadius * 2.0
    let step: CGFloat = 1 
    
    if borderView.layer.cornerRadius - step / 2.0 ... borderView.layer.cornerRadius + step / 2.0 ~= toValue / 2.0 {
      constraints
      .filter{ $0.identifier == "animationKey" }
      .forEach {
        $0.constant = toValue
        self.borderView!.layer.cornerRadius = toValue / 2.0
      }
      finished = true
      return
    }
    
    constraints
      .filter{ $0.identifier == "animationKey" }
      .forEach {
        $0.constant -= toValue > $0.constant ? -step : step
        self.borderView!.layer.cornerRadius = $0.constant / 2.0
    }
  }
}