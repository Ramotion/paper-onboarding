//
//  GestureControl.swift
//  AnimatedPageView
//
//  Created by Alex K. on 21/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

protocol GestureControlDelegate: class {
    func gestureControlDidSwipe(_ direction: UISwipeGestureRecognizer.Direction)
}

public class GestureControl: UIView {

    weak var delegate: GestureControlDelegate!
    
    public private(set) var swipeLeft: UISwipeGestureRecognizer!
    public private(set) var swipeRight: UISwipeGestureRecognizer!

    init(view: UIView, delegate: GestureControlDelegate) {
        self.delegate = delegate

        super.init(frame: CGRect.zero)

        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(GestureControl.swipeHandler(_:)))
        swipeLeft.direction = .left
        swipeLeft.delegate = self  /// reference the gesture recognizer delegate
        addGestureRecognizer(swipeLeft)

        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(GestureControl.swipeHandler(_:)))
        swipeRight.direction = .right
        swipeRight.delegate = self /// reference the gesture recognizer delegate
        addGestureRecognizer(swipeRight)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear

        view.addSubview(self)
        // add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            (view, self) >>>- {
                $0.attribute = attribute
                return
            }
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Gesture recognizer delegate
/// the default modal presentation style in iOS 13 is a page sheet
/// if Paper Onboarding is presented as a page sheet, this function is **required to enable swiping**
/// because there is a built-in gesture (that dismisses the page sheet) which conflicts with the swipe gesture
///
/// with this function, **both the swipe gesture and the built-in gesture work!**
extension GestureControl: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

// MARK: actions

extension GestureControl {

    @objc dynamic func swipeHandler(_ gesture: UISwipeGestureRecognizer) {
        delegate.gestureControlDidSwipe(gesture.direction)
    }
}
