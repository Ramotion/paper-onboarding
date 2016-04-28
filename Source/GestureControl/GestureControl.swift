//
//  GestureControl.swift
//  AnimatedPageView
//
//  Created by Alex K. on 21/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

protocol GestureControlDelegate {
  func gestureControlDidSwipe(direction: UISwipeGestureRecognizerDirection)
}

class GestureControl: UIView {
  
  let delegate: GestureControlDelegate
  
  init(view: UIView, delegate: GestureControlDelegate) {
    self.delegate = delegate
    
    super.init(frame: CGRect.zero)
    
    let swipeLeft       = UISwipeGestureRecognizer(target: self, action: #selector(GestureControl.swipeHandler(_:)))
    swipeLeft.direction = .Left
    addGestureRecognizer(swipeLeft)
    
    let swipeRight       = UISwipeGestureRecognizer(target: self, action: #selector(GestureControl.swipeHandler(_:)))
    swipeRight.direction = .Right
    addGestureRecognizer(swipeRight)
    
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

}