//
//  GestureControl.swift
//  AnimatedPageView
//
//  Created by Alex K. on 21/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

@objc protocol GestureControlDelegate {
  func gestureControlDidSwipe(direction: UISwipeGestureRecognizerDirection)
  func gestureControlDidTap(tapPoint: CGPoint)
  optional func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool
}

class GestureControl: UIView {
  
  let delegate: GestureControlDelegate
  
  init(view: UIView, delegate: GestureControlDelegate) {
    self.delegate = delegate
    
    super.init(frame: CGRect.zero)
    
    let swipeLeft       = UISwipeGestureRecognizer(target: self, action: #selector(GestureControl.swipeHandler(_:)))
    swipeLeft.direction = .Left
    swipeLeft.delegate = self
    addGestureRecognizer(swipeLeft)
    
    let swipeRight       = UISwipeGestureRecognizer(target: self, action: #selector(GestureControl.swipeHandler(_:)))
    swipeRight.direction = .Right
    swipeRight.delegate = self
    addGestureRecognizer(swipeRight)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(GestureControl.tapHandler(_:)))
    tap.delegate = self
    addGestureRecognizer(tap)
    
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor                           = .clearColor()
    
    view.addSubview(self)
    // add constraints 
    for attribute: NSLayoutAttribute in [.Left, .Right, .Top, .Bottom] {
      (view, self) >>>- {
        $0.attribute = attribute
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: actions

extension GestureControl {
  
  dynamic func swipeHandler(gesture: UISwipeGestureRecognizer) {
    delegate.gestureControlDidSwipe(gesture.direction)
  }

  dynamic func tapHandler(gesture: UITapGestureRecognizer) {
    let tapPoint = gesture.locationInView(self)
    delegate.gestureControlDidTap(tapPoint)
  }
}


// MARK: - UIGestureRecognizerDelegate Methods:

extension GestureControl : UIGestureRecognizerDelegate {

    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.delegate.gestureRecognizerShouldBegin?(gestureRecognizer) ?? true
    }
    
}
