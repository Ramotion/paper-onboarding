//
//  GestureControl.swift
//  AnimatedPageView
//
//  Created by Alex K. on 21/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

@objc protocol GestureControlDelegate {
    func gestureControlDidSwipe(_ direction: UISwipeGestureRecognizerDirection)

    func gestureControlDidTap(tapPoint: CGPoint)

    @objc optional func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool
}

class GestureControl: UIView {

    let delegate: GestureControlDelegate

    init(view: UIView, delegate: GestureControlDelegate) {
        self.delegate = delegate

        super.init(frame: CGRect.zero)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(GestureControl.swipeHandler(_:)))
        swipeLeft.direction = .left
        swipeLeft.delegate = self
        addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(GestureControl.swipeHandler(_:)))
        swipeRight.direction = .right
        swipeRight.delegate = self
        addGestureRecognizer(swipeRight)

        let tap = UITapGestureRecognizer(target: self, action: #selector(GestureControl.tapHandler(_:)))
        tap.delegate = self
        addGestureRecognizer(tap)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        view.addSubview(self)
        // add constraints
        for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
            (view, self) >>>- {
                $0.attribute = attribute
                return
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: actions

extension GestureControl {

    dynamic func swipeHandler(_ gesture: UISwipeGestureRecognizer) {
        delegate.gestureControlDidSwipe(gesture.direction)
    }

    dynamic func tapHandler(_ gesture: UITapGestureRecognizer) {
        let tapPoint = gesture.location(in: self)
        delegate.gestureControlDidTap(tapPoint: tapPoint)
    }
}


// MARK: - UIGestureRecognizerDelegate Methods:

extension GestureControl: UIGestureRecognizerDelegate {

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.delegate.gestureRecognizerShouldBegin?(gestureRecognizer: gestureRecognizer) ?? true
    }

}
