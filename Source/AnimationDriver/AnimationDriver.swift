//
//  AnimationDriver.swift
//  AnimatedPageView
//
//  Created by Alex K. on 18/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

protocol Animatable {
  func animationTick(dt: Double, inout finished: Bool)
}

class AnimationDriver {
  
  private var displayLink: CADisplayLink?
  private var animations = [Animatable]()
  
  init() {
    displayLink = createDisplayLink()
  }
  
  deinit {
    displayLink?.invalidate()
  }
}

// MARK: control

extension AnimationDriver {
  
  func addAnimationObject(animation: Animatable) {
    animations.append(animation)
    if animations.count == 1 {
      displayLink?.paused = false
    }
  }
}

// MARK: configuring 

extension AnimationDriver {
  
  private func createDisplayLink() -> CADisplayLink {
    let displayLink = Init(CADisplayLink(target: self, selector: #selector(AnimationDriver.animationTick(_:)))) {
      $0.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
      $0.paused = true
    }
    return displayLink
  }

  // selector
  dynamic func animationTick(displayLink: CADisplayLink) {
    
    animations = animations.filter {
      var finished = false
      $0.animationTick(displayLink.duration, finished: &finished)
      return !finished
    }
    
    if animations.count == 0 {
      displayLink.paused = true
    }
  }
}